#!/usr/bin/python3

import os

f = open("config.cfg", "r")
attributes = {}
for line in f.readlines():
    if line[0] == "#":
        continue
    attr = line.split(" = ")[0]
    val = line.split(" = ")[1]
    print(attr, val)
    attributes[attr] = val.replace("\n", "")

color = attributes["primary_color"]
r = color.split(" ")[0]
g = color.split(" ")[1]
b = color.split(" ")[2]
os.system("sed -i '/cnew = /c\cnew = \({}\, {}\, {}\, 255\)' change_color.py".format(r, g, b))
os.system("sed -i '/pcolor/c\ \\\definecolor{}{}\{}\,{}\,{}' 007-colors.tex".format("{pcolor}", "{rgb}", "{" + str(int(r)/255.), int(g)/255., str(int(b)/255.) + "}"))
