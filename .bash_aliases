function mkcd
{
    mkdir $1;
    cd $1;
}

function loop
{
    step=$1;
    datefin=$(($(date +%s)+$2));
    shift 2;
    eval "$@";
    sleep $step
    newtime=$(($datefin - $(date +%s)));
    if [ "$newtime" -gt 0 ]
    then eval "loop $step $newtime \"$@\" "
    fi
}

function pinguntilsuccess
{
    while ! ping -c1 "$1";
    do
        date;
    done;
}

alias vpnstart="sudo openvpn --config /home/victor/.openvpnconfig/nyu_new_network.ovpn"

alias h="history"
alias le="less"

# Use only on VirtualBox guest system
#alias mountHostDropbox="sudo mount -t vboxsf -o uid=$UID,gid=$(id -g) Dropbox ~/Dropbox"


alias teamspeak="/opt/TeamSpeak3-Client-linux_amd64/ts3client_runscript.sh"

#alias android-studio="/home/victor/android-studio/bin/studio.sh"
