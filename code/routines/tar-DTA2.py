#!/usr/bin/env python
# coding: utf8
import os
import sys


# checks in a folderpath, if there are dicoms in it.
def is_dcm( folderpath ):
	if not os.path.exists(folderpath):
		folderpath = folderpath.replace("/1/", "/2/")
	if not os.path.exists(folderpath):
		folderpath = folderpath.replace("/2/", "/3/")
	for folder in os.listdir( folderpath ):
		if ".DS_Store" in folder or ".json" in folder or ".nii" in folder:
			continue
		for file in os.listdir( folderpath + folder ):
			if ".dcm" in file:
                        	return True
	return False


# the main function generates mkdir and find commands for creating tars per subjects in the outputPath.
def main():
	inputPath = "/data/BnB_USER/Plaeschke/DTA_Studie/MRI_Data/MultiState_072015/DATA/DTAGE2/"
	outputPath = "/data/BnB_TEMP/Kadelka/sourcedata_DTA/"

	for subject in os.listdir(inputPath):
		if not "T1" == subject[:2]:
			continue
		elif is_dcm(inputPath + subject + "/scans/1/"):
			print ("mkdir -p " + outputPath + subject + "/")
			print ("find " + inputPath + subject + "/scans/ -name \"*.dcm\" | tar -cvf " + outputPath + subject + "/" + subject + ".tar -T -")
main()
