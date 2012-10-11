import os
import re

REMOVAL_TYPES = ['.o','.ali']

def clean_dir ():
    for file in os.listdir(os.getcwd()):
        if re.search('|'.join(REMOVAL_TYPES),file):
            os.remove(file)

if __name__ == "__main__":
    print ("Cleaning out files")
    clean_dir()
