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

alias oops="history -d \$(history | tail -n2 | head -n1 | tr -s ' ' | cut -d' ' -f 2); history -w"


alias commandofwindow="ps -o command \"\$(xprop _NET_WM_PID | cut -d' ' -f3)\" | tail -n +2"

# Hide new path when cd'ing (because of $CDPATH)
alias cd=">/dev/null cd"
