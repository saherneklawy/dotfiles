#!/usr/bin/env python2

delta_y = 29.966602 - 29.968305
delta_x = 31.253639 - 31.249516


start_y, start_x = 29.968305, 31.249516

template = 'https://maps.google.com/?ll=%s,%s&spn=0.001768,0.00327&t=h&z=19' # %y,x
named_template = template + '#%s'

width = input("width: ")
height = input("height: ")


for i in range(height):
    y = start_y + i * delta_y
    name_y = chr(ord('A') + i)
    for j in range(width):
        name_x = str(j+1)
        name = name_y + name_x

        x = start_x + j * delta_x

        print named_template %(y, x, name)

