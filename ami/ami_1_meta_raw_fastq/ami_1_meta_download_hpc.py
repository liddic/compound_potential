# # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # #
# # Download fastq files
# # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # #

# Shift + Option + E  # to run code chunks
# Code completion: (Basic) Ctrl + Space  ;  (SmartType) Ctrl + Shift + Space


import os
import sys
import json

print(sys.path)
requestsPath = '/home/lidd0026/miniconda3/lib/python3.8/site-packages'

sys.path.append(requestsPath)

import requests
import hashlib   # for md5sum check downloads



# set working directory
workDir = '/scratch/user/lidd0026/ami_1_meta_raw_fastq'
os.chdir(workDir)
print("Current Working Directory: ",os.getcwd())


## read in list of urls
with open( "urls_to_metagenome_data_7_5_to_45_clay_temperate-USETHIS.txt" , "r" ) as f:
    urls = f.readlines()


# read in list of md5checksums
with open( "md5sums_for_metagenome_data_7_5_to_45_clay_temperate-USETHIS.txt" , "r" ) as f:
    md5Sums = f.readlines()
print( md5Sums[0] )
len(md5Sums) # 614



### Download and check fastq files

#$CKAN_API_KEY
with open( "/home/lidd0026/CKAN_API_KEY__CL.txt" , "r" ) as f:
    CKAN_API_KEY = f.read()
f.closed # True
print(CKAN_API_KEY)
type(CKAN_API_KEY) # <class 'str'>

rawFastqDir = "/scratch/user/lidd0026/ami_1_meta_raw_fastq"

HEADERS = {'Authorization':CKAN_API_KEY ,'Destination':rawFastqDir }

for i in range(len(urls)):
    #i=0
    print("Downloading file #", i," ...")
    thisDownload = urls[i]
    thisDownload = thisDownload.replace("\n", "")
    print(thisDownload)
    thisFileName = os.path.basename(thisDownload)

    #attempts = 0
    okDownload = False

    res = requests.request('GET', thisDownload, headers = HEADERS , allow_redirects=True)
    type(res) # <class 'requests.models.Response'>

    open( os.path.join(rawFastqDir,thisFileName) ,'wb').write(res.content)

    # md5 check sums?
    md5Sums[i]                  # e.g. '6c022bb13946db0c859f1a5add7ffecd\t12424_1_PE_550bp_BASE_UNSW_H2TKNBCXX_TCTCGCGC-GGCTCTGA_L001_R1.fastq.gz\n'
    txt = md5Sums[i]
    orig_md5sum = txt.split("\t")[0]
    orig_md5sum_FileName = txt.split("\t")[1]
    orig_md5sum_FileName = orig_md5sum_FileName.replace("\n","")

    thisFileName == orig_md5sum_FileName # True
    print("File names for download # ",i," are the same:      ", thisFileName == orig_md5sum_FileName )

    this_md5sum = hashlib.md5(open( os.path.join(rawFastqDir,thisFileName) , 'rb').read()).hexdigest()
    orig_md5sum == this_md5sum  # True

    print("md5sums    for download # ", i, " are the same:      ", orig_md5sum == this_md5sum)

    okDownload = (thisFileName == orig_md5sum_FileName) & (orig_md5sum == this_md5sum)

    if okDownload == True:
        print(" - - - - - - download # ", i, " successfully downloaded ... all ok! - - - - - - -")
    else:
        print(" - - - - - - DOWNLOAD # ", i, " FAILED TO DOWNLOAD PROPERLY !!! - - - - - - -")


## END OF DOWNLOAD AND MD5 CHECKSUMS