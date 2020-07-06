# Generate Modpack
mods=$(find ./mods/ -name '*.tmod' -print | sed 's/.*\//\"/' | sed 's/\.tmod/",/')
echo -e "[\n$mods\n]" > ./mods/ModPacks/generated.json


# Generate Config
cp -f ./config/serverconfig.txt ./serverconfig.txt

function prop {
    grep "^${1}=" ./serverconfig.txt | cut -d'=' -f2 | tr -d '\n' | tr -d '\r'
}

disableannouncementbox=$(prop "disableannouncementbox")
announcementboxrange=$(prop "announcementboxrange")

cat <<EOF >> ./serverconfig.txt

worldpath=./worlds/
banlist=./config/banlist.txt
modpath=./mods
modpack=generated

EOF

world=$(find ./worlds/ -name '*.wld' -print -quit)
echo -e "world=${world:-./ILLEGAL}\n" >> ./serverconfig.txt


# Generate Argument
args="-config ./serverconfig.txt"

if [ "$disableannouncementbox" = "1" ]; then
    args=$args" -disableannouncementbox"
fi
if [ -n "$announcementboxrange" ]; then
    args=$args" -announcementboxrange $announcementboxrange"
fi


# Run Server
mono --server --gc=sgen -O=all ./tModLoaderServer.exe $args
