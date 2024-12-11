from openpyxl import load_workbook
from openpyxl.styles import Color, PatternFill, Font, Border

import sys
import openpyxl
import shutil
import os
from datetime import date
from datetime import datetime

def getDate():
    today = str(date.today())
    return today
def getTime():
    currentDateAndTime = datetime.now()
    currentTime = currentDateAndTime.strftime("%H:%M:%S")
    return str(currentTime)

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def readTextFile(path):
    file = open(path,"r",encoding='utf-8')
    return file.read()

def readTextLines(path):
    file = open(path,"r",encoding='utf-8')
    return file.readlines()

def RN(text):
    if text == None:
        return ''
    return text

def getIfSkipped(inputVer):
    if inputVer == '':
        return False
    return not (ver in inputVer)

def replaceLines(lines,lastRowIncludes,keyReplacee,keyReplacer,replacement,filePath):
    if keyReplacee == "":
        return lines
    outputLines = lines.copy()
    found = False
    for index, line in enumerate(lines):
        outputLines[index] = line.replace('[CURR_DATE]',getDate())
        outputLines[index] = outputLines[index].replace('[CURR_TIME]',getTime())
        if keyReplacee in line:
            # print(lastRowIncludes)
            # print(lines[index - 1])
            # print()
            if lastRowIncludes == "" or lastRowIncludes in lines[index - 1]:
                print("替换文本 from & to: \n" + keyReplacee + '\n' + keyReplacer)
                outputLines[index] = line.replace(keyReplacee,keyReplacer)
                found = True
                for key, value in replacement.items():
                    print("替换子文本 from: " + key + '\nto: ' + value)
                    outputLines[index] = outputLines[index].replace(key,value) 
                print()
    if not found:
        print(bcolors.FAIL)
        print("ERROR Not Found: " + keyReplacee + " in " + filePath)
        print(bcolors.OKGREEN)
    return outputLines


# Program Start
xlsxListPath = sys.argv[1]
startCol = int(sys.argv[2])
ver = sys.argv[3]

# Load Workbook
wb = load_workbook(filename = xlsxListPath)

filePaths = []

print(bcolors.OKGREEN)
print('正在替换代码内嵌文本 ' + xlsxListPath)


for sheet in wb._sheets:
    filePath = sheet.cell(row=1, column=startCol).value
    print("替换文件名：" + filePath)
    textLines = readTextLines(filePath)

    rowID = 2
    while sheet.cell(row=rowID, column=startCol).value != 'end' and rowID < 10000:
        
        if sheet.cell(row=rowID, column=startCol).value != None:

            with open(filePath, 'w', encoding='utf-8') as f:
                f.write(''.join(textLines))

            filePath = sheet.cell(row=rowID, column=startCol).value
            textLines = readTextLines(filePath)
            rowID += 1
            continue

        currVer = RN(sheet.cell(row=rowID, column=startCol+2).value)
        lastRowIncludes = RN(sheet.cell(row=rowID, column=startCol+1).value)
        # print(lastRowIncludes)
        keyReplacee = RN(sheet.cell(row=rowID, column=startCol+3).value)
        keyReplacer = RN(sheet.cell(row=rowID, column=startCol+4).value)
        replacement = {}
        colID = startCol + 5
        while sheet.cell(row=rowID, column=colID).value != None:
            replacement[sheet.cell(row=rowID, column=colID).value] = sheet.cell(row=rowID, column=colID+1).value
            colID += 2

        textLines = replaceLines(textLines,lastRowIncludes,keyReplacee,keyReplacer,replacement,filePath)

        rowID += 1

    # print(''.join(textLines))
    with open(filePath, 'w',encoding='utf-8') as f:
        f.write(''.join(textLines))



    # print(text2Modify)

# input(bcolors.OKGREEN + "Any key..")
print(bcolors.OKGREEN)
print()
print('db Data Import complete.')
# input("Press Return to proceed..")



