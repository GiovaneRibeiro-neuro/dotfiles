#!/bin/bash
#
# rclone-sync.sh
# 
# Realiza a sincronização entre pastas utilizando o rclone.
# Dependências:
# * rclone
# * Alguma configuração remota já realizada
#
# Uso:
# rclone-sync.sh <remote_name> <local_dir> <remote_dir>
#

if [ "$#" != "1" ]; then
    echo "*** Missing profile name! Usage: rclone-sync.sh <profile_name>"
    exit 1
fi

PROFILE=$1
CONF=$HOME/.config/rclone-sync/$PROFILE.conf
CONF_RESYNC_FLAG=$HOME/.config/rclone-sync/$PROFILE.conf.resync

if [ ! -f "$CONF" ]; then
    echo "Profile conf '$CONF' not found."
    exit 1
fi

# load the conf
source "$CONF"
    
# Log
LOGFILE=$HOME/.logs/rclone-sync.log.$(date +"%Y-%m-%d")
mkdir -p "$(dirname "$LOGFILE")"
echo "===== $(date) - Início da sincronização =====" >> "$LOGFILE"

# Garante que a pasta local existe
[ ! -d $LOCAL_DIR ] && mkdir -p "$LOCAL_DIR"

if [ -f $CONF_RESYNC_FLAG ]; then
    # arquivo já existe, seria uma sincronização comum
    rclone bisync "$LOCAL_DIR" "$REMOTE_NAME:$REMOTE_DIR" \
      --log-file="$LOGFILE" \
      --log-level=INFO
else
    # arquivo não existe. Faz a sincronização com --resync, e depois cria um arquivo de flag
    rclone bisync "$LOCAL_DIR"  "$REMOTE_NAME:$REMOTE_DIR" \
      --log-file="$LOGFILE" \
      --log-level=INFO \
      --resync
    echo "syncOK" > $CONF_RESYNC_FLAG
fi

echo "✅ Sincronização finalizada em $(date)" >> "$LOGFILE"
