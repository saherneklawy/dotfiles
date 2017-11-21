#! /usr/bin/env python

import os,re

log_file = '/home/saher/Desktop/smartsoft_log'
svn_log_seperator  = '------------------------------------------------------------------------'
svn_dir = '/home/saher/workspace/smartsoft/smartsoft/'
mail_filter = '[smartsoft svn commit]'
message_file = '/tmp/commit_mail'

mail_from = 'saher.neklawy@gmail.com'
mail_to = 'saher.neklawy@gmail.com'

smtp_server = "smtp.gmail.com:587"
smtp_user = "saher.neklawy"
smtp_pass = "Ifrit_Gloves"

def send_mail(subject,mail):
    mail_file = open(message_file,'w')
    mail_file.write(mail)
    mail_file.close()
    mail_command = 'sendEmail -f %s -t %s -u "%s" -s %s -xu "%s" -xp "%s" -o message-file="%s"' % (mail_from, mail_to, subject, smtp_server, smtp_user, smtp_pass,message_file)
    print mail_command
    os.system(mail_command)

print "analyzing old log file"

old_log_f = open(log_file)
old_log = old_log_f.read().split(svn_log_seperator)
old_log_f.close()

print "updating svn"
os.system("/usr/local/bin/svn update %s" % svn_dir)
os.system("/usr/local/bin/svn log %s > %s" % (svn_dir,log_file))
print "got new log"


new_log_f = open(log_file)
new_log = new_log_f.read().split(svn_log_seperator)
new_log_f.close()

delta = set(new_log) - set(old_log)

for commit in delta:
    l = [x for x in commit.split('\n') if x]
    details = l[0].split('|')
    subject = "%s %s %s" %(mail_filter,details[0],details[1])
    f_diff=os.popen('/usr/local/bin/svn diff -c %s %s' % (details[0], svn_dir))
    diff = f_diff.read()
    f_diff.close()
    mail = "%s\n%s" % (commit, diff)
    send_mail(subject,mail)
print "done\n\n"
