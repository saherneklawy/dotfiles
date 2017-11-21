#! /usr/bin/env python
import re,sys,time

def get_ms(hr,mins,sec,ms):
  return int(ms)+int(sec)*1000+int(mins)*60000+int(hr)*3600000

def get_time_formated(time):
  hr,time = time/3600000,time%3600000
  mins,time = time/60000,time%60000
  sec,time = time/1000,time%1000
  ms = time
  return "{0:#02}:{1:#02}:{2:#02},{3:#03}".format(hr,mins,sec,ms)

if len(sys.argv)!=3:
  print "usage: delayStr.py file_name delay_ms"
  sys.exit(1)
f_in_name = sys.argv[1]
delay_ms = int(sys.argv[2])
f_out_name = sys.argv[1][:-4]+"_delayed.srt"
f_in = file(f_in_name)
f_out = file(f_out_name,'w')
for l in f_in:
  res = re.match("(\d{2}):(\d{2}):(\d{2}),(\d{3}) --> (\d{2}):(\d{2}):(\d{2}),(\d{3})",l)
  if res:
    time_ms_1 = get_ms(res.group(1),res.group(2),res.group(3),res.group(4))+delay_ms
    time_ms_2 = get_ms(res.group(5),res.group(6),res.group(7),res.group(8))+delay_ms
    f_out.write(get_time_formated(time_ms_1)+" --> "+get_time_formated(time_ms_2)+"\n")
  else:
    f_out.write(l)

f_in.close()
f_out.close()
