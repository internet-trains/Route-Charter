import os
import shutil
import subprocess

OTTDScript = "..\\OpenTTD\\game\\Route-Charter"
OwnPath = "..\\Route-Charter"

SqrFiles = [i for i in os.listdir() if ".nut" in i]
print(os.listdir("lang"))
LangFiles = [i for i in os.listdir("lang") if ".txt" in i]

subprocess.call("md "+OTTDScript, shell=True)
subprocess.call("md "+OTTDScript+"\\lang", shell=True)

for i in SqrFiles:
    print("copying " + i)
    shutil.copy(OwnPath + "\\" + i, OTTDScript)

subprocess.call("cd lang", shell=True)

for i in LangFiles:
    print("copying " + i)
    shutil.copy(OwnPath + "\\lang\\" + i, OTTDScript + "\\lang")

print("All files copied")