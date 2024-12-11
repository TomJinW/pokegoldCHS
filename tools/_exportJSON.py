from openpyxl import Workbook
from openpyxl.comments import Comment
from openpyxl import load_workbook
import openpyxl
import os
from bs4 import BeautifulSoup
import json
import sys

part = '｜'

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

def loopRemove(text):
    line = text
    while '+ ' in line:
        line = line.replace('+ ','+')
    return line

def readTextFile(path):
    file = open(path,"r",encoding='utf-8')
    return file.read()

def RN(text):
    if text == None:
        return ''
    else:
        return text.strip()
    
def emptyStr(label):
    return RN(label) == ''

def isATextLabel(text):
    components = text.strip().split(' ')
    if len(components) >= 1:
        if 'text' in components[0].lower() or 'description:'in components[0].lower() or 'receivedtm09' in components[0].lower() or '_oakrating' in components[0].lower() or 'jasmine_' in components[0].lower():
            if components[0][-1] == ':':
                return True
    else:
        return False
    return False

def isALabel(text):
    components = text.strip().split(' ')
    if len(components) >= 1:
        if len(components[0]) < 1:
            return False
        if components[0][-1] == ':':
            return True
    else:
        return False
    return False

def getStrippedLabel(text):
    components = text.strip().split(' ')
    return components[0].replace(':','')

def readLines(path):
    with open(path, 'r', encoding='utf-8') as file:
        lines = file.readlines()
        return lines

def ifLineIsEmptyOrPureComment(line):
    if len(line.strip()) > 0:
        return line.strip()[0] == ';'
    else:
        return True
    
def getGSDict():
    dlabelDict = dict()
    # for file in files:
    pathLines = readLines('xlsx/textScripts.txt')
    



    for pathWithLine in pathLines:
        path = pathWithLine.strip()
        oldlines = readLines(path)

        lines = []
        for line in oldlines:
            if len(line.strip()) > 0:
                if line.strip()[0] != ';':
                    lines.append(line)

        tmpText = []
        tmpCmd = []
        label = ''
        foundFirst = False

        for index, line in enumerate(lines):

            if isATextLabel(line):
                nextLine = lines[index + 1]
                if "text_" in nextLine.lower() or '\"' in nextLine or ifLineIsEmptyOrPureComment(nextLine):
                    if (foundFirst) and label != '':
                        dlabelDict[label] = (tmpText,path,"N/A",tmpCmd)

                    foundFirst = True
                    label = getStrippedLabel(line)
                    tmpText = []
                    tmpCmd = []

            elif isALabel(line):
                if (foundFirst) and label != '':
                    dlabelDict[label] = (tmpText,path,"N/A",tmpCmd)


                label = ""
                tmpText = []
                tmpCmd = []
            elif index == len(lines) - 1:
                if (foundFirst) and label != '':
                    dlabelDict[label] = (tmpText,path,"N/A",tmpCmd)


            elif foundFirst:
                tmpLine = line.replace(' \"',part).replace('\"',part).replace('\t','').replace('\n','')
                # print(tmpLine)
                components = tmpLine.split(part)
                # print(components)
                if len(components) >= 2:
                    if '\"' in line.strip():
                        tmpText.append(components[1].replace('\"',''))
                        tmpCmd.append(components[0])
                else:
                    components2 = line.strip().split(' ')
                    if len(components2) >= 2 and len(line.strip()) > 0:
                        if line.strip()[0] != ';':
                            newLine = ('+' + line.strip() + '+').strip() 
                            # print(newLine)
                            # print(list(newLine))
                            tmpText.append(newLine)
                            tmpCmd.append(newLine)
                    if tmpLine.strip() == 'done' or tmpLine.strip() == 'prompt' or tmpLine.strip() == 'text_end':
                        tmpCmd.append(tmpLine.strip())
    return dlabelDict





# print(bcolors.OKGREEN)
GSDict = getGSDict()
jsonOutputPath = sys.argv[1]
jsonText = "["
for tag in (GSDict):

    content = GSDict[tag]
    text = content[0]
    path = content[1]
    # print(tag)
    # print(content)
    instructions = content[3]
    header = '{\"Sentence\":{\"text\":\"'
    body = ''
    for i in range(len(instructions)):
        if i < len(text):
            if (instructions[i].strip() != text[i]):
                body += instructions[i].replace(' ','') + ' ' + (text[i]) + '\\n'
            else:
                body += (text[i].replace(' +','').replace('+','')) + '\\n'
        footer = '\",\"note\":\"\",\"state\":\"Unmarked\",\"tag\":\"'+ str(tag) + '\\n' + path.split('/')[-1] +'\"}},'
    jsonText += header + body + footer + ''

jsonText += ']'
jsonText = jsonText.replace(',]',']')
data = json.loads(jsonText)
with open(jsonOutputPath, 'w', encoding='utf-8') as file:
    json.dump(data, file, ensure_ascii=False, indent=4)
# print(jsonText)