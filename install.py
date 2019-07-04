import os
import shutil

OTTDScript = "..\\OpenTTD\\game\\ORC"
OwnPath = "..\\ORC"

print(os.listdir())

SqrFiles = [i for i in os.listdir() if ".nut" in i]

for i in SqrFiles:
    print("copying " + i)
    shutil.copy(OwnPath + "\\" + i, OTTDScript)

print("All files copied")


    