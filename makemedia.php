#!/usr/bin/php -q
<?php

if ($argc > 1) {
    // very basic cmd line option parsing
    $options = (getopt("d", [], $n));
    $entry = $argv[$n];
    
    global $debug;
    $debug = array_key_exists("d", $options);

    if (is_dir($entry)) {
        // Create media files for a directory, including subdirectories
        $imagedir = findRootDir($entry) . "/source/img/";
        parseDir(dir(realpath(__DIR__ . "/" . $entry)));
        exit(0);
    }
    if (is_file($entry)) {
        // Create media for a single file
        $dir = dirname($entry);
        $imagedir = findRootDir($dir) . "/source/img/";
        $config = getConfig(dir($dir));
        $filename = basename($entry);
        if (key_exists($filename, $config)) {
            createMedia(dirname($entry), $filename, $config[$filename]);
            exit(0);
        }
        else {
            el("No config entry for " . $entry);
            exit(1);
        }
    }
} else {
    // Create all media files
    chdir(findRootDir(realpath(".")));
    $dir = dir("./source/qml");
    $imagedir = realpath("./source/img/");
    parseDir($dir);
    exit(0);
}

/**
 * Find the root directory of the checked out HIG project
 */
function findRootDir($dir) {
    global $imagepath;
    
    while (is_dir($dir)) {
        if (is_dir($dir . "/source")) {
            return realpath($dir);
        }
        $dir .= "/..";
    }
    echo "Could not find HIG root directory.";
    exit(1);
}

/**
 * Parse a direcotry and its subdirectory
 */
function parseDir(\Directory $dir) {
    $config = getConfig($dir);
    el("Parsing " . $dir->path);

    while (false !== ($entry = $dir->read())) {
        if (is_dir($dir->path . "/" . $entry)) {
            if ($entry[0] != ".") {
                parseDir(dir($dir->path . "/" . $entry));
            }
        }

        if (key_exists($entry, $config)) {
            createMedia($dir->path, $entry, $config[$entry]);
        }
    }
    $dir->close();
}

/**
 * Read the json config file or return an empty config
 */
function getConfig(\Directory $dir) {
    if (is_file($dir->path . "/config.json")) {
        return json_decode(file_get_contents($dir->path . "/config.json"), true);
    }
    return [];
}

/**
 * Create a media file according to the config
 */
function createMedia($path, $filename, $config) {
    global $imagedir;
    $pathinfo = pathinfo($path. "/" . $filename);
    
    el("Changing to " . $path . "\n");
    if (chdir($path)) {
        echo "Created media for " . $filename . " ... ";
        
        // Setting env variables
        $options = "";
        
        if (isset($config["controls"]) && $config["controls"] == "mobile") {
            putenv("QT_QUICK_CONTROLS_MOBILE=1");
            putenv("QT_QUICK_CONTROLS_STYLE=Plasma");
        }
        else {
            putenv("QT_QUICK_CONTROLS_MOBILE=0");
            putenv("QT_QUICK_CONTROLS_STYLE=org.kde.desktop");
        }
        
        if (isset($config["autostart"])) {
            $options .= " -a " . $config["autostart"];
        }
        
        if (isset($config["scale"]) && is_numeric($config["scale"])) {
            putenv("QT_SCALE_FACTOR=" . $config["scale"]);
        }
        else {
            putenv("QT_SCALE_FACTOR=1");
        }
        
        if (isset($config["fps"])) {
            $options .= " -f " . $config["fps"];
        }
        
        if (isset($config["duration"])) {
            $options .= " -s " . $config["duration"];
        }
        
        
        switch ($config["type"]) {
            case "png":
                el("qmlgrabber " . $filename . $options );
                cmdExec("qmlgrabber " . $filename . $options );
                $output = $imagedir . $pathinfo["filename"] . ".png";
                el("moving file to " . $output);
                if (is_file($output)) {
                    unlink($output);
                }
                rename($path . "/Screenshot.png", $output);
            break;
            case "webm":
                el("qmlgrabber " . $options . " " . $filename);
                cmdExec("qmlgrabber " . $options . " " . $filename);
                cmdExec("ffmpeg -r 60 -f image2 -i Frames/Frame-%d.png -vcodec libvpx -b:v 1M video.webm");
                $output = $imagedir . $pathinfo["filename"] . ".webm";
                el("moving file to " . $output);
                if (is_file($output)) {
                    unlink($output);
                }
                rename($path . "/video.webm", $output);
                cmdExec("rm -r Frames");
            break;
            case "gif":
                cmdExec("qmlgrabber " . $filename . $options);
                cmdExec("ffmpeg  -f image2 -i Frames/Frame-%d.png -vf fps=10,scale=240:-1:flags=lanczos,palettegen palette.png");
                cmdExec('ffmpeg  -f image2 -i Frames/Frame-%d.png -i palette.png -filter_complex "fps=20,scale=240:-1:flags=lanczos[x];[x][1:v]paletteuse" output.gif');
                $output = $imagedir . $pathinfo["filename"] . ".gif";
                el("moving file to " . $output);
                if (is_file($output)) {
                    unlink($output);
                }
                rename($path. "/output.gif", $output);
                cmdExec("rm -r Frames");
                cmdExec("rm palette.png");
            break;
        }
        // Reset env variables back to default
        putenv("QT_QUICK_CONTROLS_MOBILE=0");
        putenv("QT_QUICK_CONTROLS_STYLE=org.kde.desktop");
        putenv("QT_SCALE_FACTOR=1");
        echo " done \n";
    }
    else {
        echo "Could not change to $path \n";
        exit(1);
    }
}

/**
 * Executing a bash cmd
 * printing out the result, if an error occured
 * exit(1) on error
 */
function cmdExec($cmd) {
    global $debug;
    
    exec($cmd . " 2>&1", $result, $return);
    if ($debug || $return !== 0) {
        print_r($result);
    }
    
    if ($return !== 0) {
        exit(1);
    }
}

/**
 * Output if -d is set
 */
function el($str) {
    global $debug;
    if ($debug) {
        echo $str . "\n";
    }
}
