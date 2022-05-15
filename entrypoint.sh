set -e
set -x

# Run init scripts
for f in ./init/*.sh; do
  bash "$f"
done

# Generate mod folder and modpack
mkdir -p "./_mods/ModPacks/"
cp ./mods/*.tmod ./_mods/
mods=$(find ./_mods/ -name '*.tmod' -print | sed 's/.*\//\"/' | sed 's/\.tmod/",/')
echo -e "[\n$mods\n]" > ./_mods/ModPacks/generated.json


# Generate config
cp -f ./config/serverconfig.txt ./serverconfig.txt

function prop {
    grep "^${1}=" ./serverconfig.txt | cut -d'=' -f2 | tr -d '\n' | tr -d '\r'
}

disableannouncementbox=$(prop "disableannouncementbox")
announcementboxrange=$(prop "announcementboxrange")

cat <<EOF >> ./serverconfig.txt

worldpath=./worlds/
banlist=./config/banlist.txt
modpath=./_mods/
modpack=generated

EOF

worldname=$(prop "worldname")
world=$(find ./worlds/ -name '*.wld' -print -quit)
echo -e "world=${world:-"./worlds/$worldname.wld"}\n" >> ./serverconfig.txt


# Generate arguments
args="-config ./serverconfig.txt"

if [ "$disableannouncementbox" = "1" ]; then
    args="$args -disableannouncementbox"
fi
if [ -n "$announcementboxrange" ]; then
    args="$args -announcementboxrange $announcementboxrange"
fi


# Run Server
export SERVER_EXECUTABLE="mono"
exec ./TerrariaServerWrapper --server --gc=sgen -O=all ./tModLoaderServer.exe $args
