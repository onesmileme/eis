#! /usr/bin/python
from sys import argv
import os

images = {}
configjson = ""
outdir = ""

def shortName(name):
    index = name.find("@",0)
    if index > 0 :
        return name[0:index]

def makeImageset(name , path):

    global outdir
    global configjson
    
    pwd = os.getcwd()
    imagesetPath = name +".imageset"
    os.chdir(outdir)
    
    cmd = "mkdir " +imagesetPath
    os.system(cmd)
    cmd = "cp " + path+"/"+name+"@2x.png " + imagesetPath
    os.system(cmd)
    cmd = "cp " + path+"/"+name+"@3x.png "+ imagesetPath
    os.system(cmd)
    #os.system("cd " + imagesetPath)

    
    json = configjson.replace("2xpng",name+"@2x.png")
    json = json.replace("3xpng",name+"@3x.png")

    f = file(imagesetPath+"/Contents.json","w")
    f.write(json)
    f.close()

    os.chdir(pwd)
    
    #os.system("cd ..")
    
        
def handleDir(path):
    
    
    if os.path.isdir(path):
        subitems = os.listdir(path)
        for item in subitems:
            sname = shortName(item)
            images[sname] = sname


    pwd = os.getcwd()
    path = pwd + "/" + path
    
   #print "images are:\n" , images , "\n\n"
    keys = images.keys()
    for k in keys :

        if not  k is None :
            makeImageset(k,path)
        else:
            pass
    
    
def test():

    if (len(argv) < 4):
        print "Usage imageset.py Contents.json_path image_dir out_dir"
        exit(0)

    global outdir
    global configjson
    
    f = file(argv[1])
    json = ""
    for line in f:
        json = json +  line

    f.close()
    outdir = argv[3]


    if outdir.endswith("/") :
        outdir = outdir[:-1]
        
    if outdir != "." :
        cmd = "rm -rf " + outdir + " ; mkdir " + outdir
        os.system(cmd)
    
    configjson = json
    
    handleDir(argv[2])

if __name__ == '__main__':
    test()