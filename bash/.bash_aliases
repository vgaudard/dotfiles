function mkcd
{
    mkdir $1 -p;
    cd $1;
}

function pinguntilsuccess
{
    while ! ping -c1 "$1";
    do
        date;
    done;
    notify-send "Ping succeeded"
}

alias t="todo"

alias commandofwindow="ps -o command \"\$(xprop _NET_WM_PID | cut -d' ' -f3)\" | tail -n +2"
