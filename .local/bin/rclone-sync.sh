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

# Sincronização local → remoto
echo "🔼 Enviando arquivos locais para o OneDrive..." >> "$LOGFILE"
rclone copy "$LOCAL_DIR" "$REMOTE_NAME:$REMOTE_DIR" --update --create-empty-src-dirs --log-file="$LOGFILE" --log-level=INFO

# Sincronização remoto → local
echo "🔽 Baixando arquivos do OneDrive para local..." >> "$LOGFILE"
rclone copy "$REMOTE_NAME:$REMOTE_DIR" "$LOCAL_DIR" --update --create-empty-src-dirs --log-file="$LOGFILE" --log-level=INFO

echo "✅ Sincronização finalizada em $(date)" >> "$LOGFILE"
