[ -x /usr/bin/keychain ] && \
    /usr/bin/keychain id_dsa
HOSTNAME=`hostname`
[[ -f $HOME/.keychain/$HOSTNAME-sh ]] && \
    source $HOME/.keychain/$HOSTNAME-sh
