# Helper methods
DlFileDirect () {
    if [ -f "/tml-server/mods/$1" ]; then echo "Skipping $1"; else curl -L -o "/tml-server/mods/$1" "$2"; fi
}

DlModBrowser () {
    DlFileDirect "$1.tmod" "https://mirror.sgkoi.dev/tModLoader/download.php?Down=mods/$1.tmod"
}

DlGithubFile () {
    DlFileDirect "$1.tmod" "https://github.com/$3/$4/releases/download/$2/$1.tmod"
}

# Run init script
echo "Executing $1"
set -ex
source "$1"
