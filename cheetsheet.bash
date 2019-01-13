#normalize mp3 volumes
find . -name "*.mp3"  -exec mp3gain -r -c -s r '{}' +

pacaur -Syua --noconfirm --noedit


#replace in file names recursively
find . -type f -name "*ï*" -execdir bash -c 'mv -- "$1" "${1//ï/i}"' bash {} \;

ps -eo pid,etime,command | grep [c]loud
kill $(ps -eo pid,etime,command | grep [c]loud | grep worker)
vim -p $(grep -l -R -P "text to search")

find ... -print0 | xargs -O ...

find . -type d -print0 | xargs -0 -I {} bash -c 'echo "$@,$(ls "$@" | wc -l)"' _ {} > {timestamp}-name-of-file.txt`
find ./ -name "*.webp" -exec dwebp {} -o {}.png \;


map(&:asdas).map().compaq

for i in `ls`; do echo $i; echo curl -XPOST 'http://localhost:9200/_aliases' -d "{ 'actions' : [ { 'add' : { 'index' : '"$i"_staging', 'alias' : '"$i"_development' } } ] }"; done

curl -XPOST http://localhost:9200/_aliases -d '{ "actions" : [ { "add" : { "index" : "items_staging", "alias" : "items_development" } } ] }'
curl -XPOST http://localhost:9200/_aliases -d '{ "actions" : [ { "add" : { "index" : "people_staging", "alias" : "people_development" } } ] }'
curl -XPOST http://localhost:9200/_aliases -d '{ "actions" : [ { "add" : { "index" : "spec_values_staging", "alias" : "spec_values_development" } } ] }'
curl -XPOST http://localhost:9200/_aliases -d '{ "actions" : [ { "add" : { "index" : "specs_staging", "alias" : "specs_development" } } ] }'
curl -XPOST http://localhost:9200/_aliases -d '{ "actions" : [ { "add" : { "index" : "tags_staging", "alias" : "tags_development" } } ] }'


# check that all assets in manifest are compiled
for i in $(cat manifest.yml | awk '{print $2}'); do [ ! -s $i ] && echo $i; done | wc -l


vim $(find . -iname *full* | grep after | grep list.txt)


curl -XPOST http://localhost:9200/_aliases -d '{ "actions" : [ { "add" : { "index" : "items", "alias" : "items_development" } } ] }'
curl -XPOST http://localhost:9200/_aliases -d '{ "actions" : [ { "add" : { "index" : "people", "alias" : "people_development" } } ] }'
curl -XPOST http://localhost:9200/_aliases -d '{ "actions" : [ { "add" : { "index" : "spec_values", "alias" : "spec_values_development" } } ] }'
curl -XPOST http://localhost:9200/_aliases -d '{ "actions" : [ { "add" : { "index" : "specs", "alias" : "specs_development" } } ] }'
curl -XPOST http://localhost:9200/_aliases -d '{ "actions" : [ { "add" : { "index" : "tags", "alias" : "tags_development" } } ] }'


for i in $(find . -iname "*png");do pngquant --quality 80-90 256 --ext .png-tmp $i && mv $i{-tmp,}; done

curl -XPOST http://localhost:9200/_aliases -d '{ "actions" => [
{ "remove" => { "index" => '', "alias" => index_alias } },
{ "add" => { "index" => new_index_name, "alias" => index_alias } } ] }'


for i in $(find . -iname "*.jpg"); do printf "$(du -h $i)\t"; echo $(identify -verbose $i | grep Interlace); done

watch -n 1 "ps -eo pid,etime,command | grep [p]hantom | cut -c1-$(tput cols)"

#http://stackoverflow.com/questions/17847390/how-to-resume-stopped-job-on-a-remote-machine-given-pid
<C-z>
jobs -l
byobu
kill -CONT <pid>

cat /usr/share/dict/american-english | sed "s/'//g" | shuf -n 200 --random-source=/dev/random | shuf -n 5  --random-source=/dev/urandom


# expand kickass.to episodes list
$('#wrapperInner > div.mainpart > table > tbody > tr > td:nth-child(1) > div > div.infoList > div').click()

# remove from from episode list in kickass.to
$('div.torrentname > div > a:not([href *= "commie"])').parent().parent().parent().parent().remove()

l1.txt - l2.txt: diff <(cat l1.txt | sort) <(cat l2 | sort) -y | grep "<" | awk '{print $1}'

# sort folders by size
for i in `ls`; do echo `du -s -h $i 2> /dev/null`; done | sort -h -r | head -n 20
du -h --max-depth=1 | sort -hr

# sort folders by file count
for i in /*; do echo `find $i | wc -l` $i; done | sort -hr

# usuage stats by inode/file count
df -i

sudo postsuper -d ALL deferred

# current terminal width
tput cols


gem wich %gemname% # get gem location

ssh-keygen -f "/home/trustious/.ssh/known_hosts" -R analytics-1d-1.trustious.com


# script progress %
watch "wc -l item_category_paths.csv | awk '{print \$1*100/3759}'"
