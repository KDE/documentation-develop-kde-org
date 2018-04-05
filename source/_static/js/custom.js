/**
 * Resets the "View page source" link to point to the current pages source file in the Phabricator git repo. 
 */
function resetViewPageSourceLink() {
    let path = (window.location.pathname === "/") ? "/index.html" : window.location.pathname;
    
    // Grab the "View page source" anchor tag
    let viewPageSourceLink = document.getElementsByClassName("wy-breadcrumbs-aside")[0].firstElementChild;
    
    if (path !== "/index.html") {
        // Replace html with rst, so we can reference the source file in the Git repo
        let newPath = path.substr(1, path.lastIndexOf(".")) + "rst";
        
        viewPageSourceLink.href = "https://phabricator.kde.org/source/websites-hig-kde-org/browse/master/source/" + newPath;
        
        return viewPageSourceLink.href;
    }

    let newPath = path.substr(1, path.lastIndexOf(".")) + "rst";
    
    viewPageSourceLink.href = "https://phabricator.kde.org/source/websites-hig-kde-org/browse/master/source/" + newPath;
    
    return viewPageSourceLink.href;
}

resetViewPageSourceLink();
