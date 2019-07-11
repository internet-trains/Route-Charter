import os
import shutil
import subprocess

OTTDScript = "..\\openttd-custom-jgrpp-0.31.2-MINGW-win64\\game\\Route-Charter"
SrcPath = "..\\Route-Charter\\src"
LangPath = "..\\Route-Charter\\lang"

SqrFiles = [i for i in os.listdir("src") if ".nut" in i]
LangFiles = [i for i in os.listdir("lang") if ".txt" in i]

subprocess.call("md "+OTTDScript, shell=True)
subprocess.call("md "+OTTDScript+"\\lang", shell=True)

for i in SqrFiles:
    print("copying " + i)
    shutil.copy(SrcPath + "\\" + i, OTTDScript)

subprocess.call("cd lang", shell=True)

for i in LangFiles:
    print("copying " + i)
    shutil.copy(LangPath + "\\" + i, OTTDScript + "\\lang")

print("All files copied")