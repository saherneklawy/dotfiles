#! /usr/bin/env python

ip = '69.63.181.12' #facebook
ip2 = '66.102.13.99' #google

l = [int(x) for x in ip.split('.')]

oct_ip = 'http://'+'.'.join([oct(x) for x in l])

hex1_ip = 'http://'+'.'.join([hex(x) for x in l])
hex_list = [x[2:] for x in [hex(x2) for x2 in l]]
for i in range(len(hex_list)):
    if len(hex_list[i])<=1:
        hex_list[i] = '0'+hex_list[i]
hex2_ip = 'http://0x'+''.join(hex_list)

int_ip = 'http://'+str(int('0x'+''.join(hex_list),16))

print 'oct ip: ',oct_ip
print 'hex 1 ip: ',hex1_ip
print 'hex 2 ip: ',hex2_ip
print 'int ip: ',int_ip
