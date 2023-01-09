# SPDX-FileCopyrightText: 2022 Alessio Mattiazzi <alem99393@gmail.com>
# SPDX-LicenseIdentifier: BSD-2-Clause

import re
import os
import requests
import sys

def test_urls():

    path = "content"
    pattern = "https?://[^ \`\t\n\r\f\v\"\'\(\)\[\]\\\<\>]*"
    timedout = 0
    error = 0
    success = 0
    ignore_urls = [url for url in list(filter(None,open("data/ignore_urls.txt","r").read().splitlines())) if url.strip()[0]!="#"]

    for path_dir, dirs, files in os.walk(path):
        files = [file for file in files if ".md" in file]
        for file in files:
            with open(path_dir+"/"+file,"r") as f:
                urls = [url for url in re.findall(pattern,f.read()) if url not in ignore_urls]
                for url in urls:
                    try:
                        response = requests.get(url)
                        if(response.status_code>=400):
                            print("PATH: " + path_dir + "/" + file + "\nURL: " + url + "\nRESPONSE CODE: " + str(response.status_code) + " FAILED\n")
                            error += 1
                        else:
                            success += 1
                    except:
                        print("PATH: " + path_dir + "/" + file + "\nURL: " + url + "\nRESPONSE CODE: TIMEOUT\n")
                        timedout += 1
    return [success,error,timedout]

if __name__ == '__main__':

    code = test_urls()
    print("Success: " + str(code[0]) + "\tFailed: " + str(code[1]) + "\tTimedout: " + str(code[2]) + "\n")
    sys.exit(code[1]+code[2])
