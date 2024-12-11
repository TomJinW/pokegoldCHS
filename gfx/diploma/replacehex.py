def readLines(path):
    with open(path, 'r') as file:
        lines = file.readlines()
        return lines

def readBinary(path):
    # Open the file in binary mode
    with open(path, 'rb') as file:
        # Read the entire file content into bytes
        byte_content = file.read()
        # Convert bytes to a list of integers, each representing a byte
        return list(byte_content)
    
lines = readLines('replacement.txt')
hexDict = dict()

for line in lines:
    comp = line.split(',')
    hexDict[int(comp[0], 16)] = int(comp[1], 16)


binary = readBinary('page2.tilemap')

for index, byte in enumerate(binary):
    if byte in hexDict:
        binary[index] = hexDict[byte]


file = open('page2.tilemap', 'wb')
try:
    ##### Write binary data to file
    file.write(bytearray(binary))
finally:
    ### Close the file
    file.close()
