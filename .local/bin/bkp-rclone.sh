#!/bin/bash

# Caminhos
RCLONE_DIR="$HOME/.config/rclone"
RCLONE_CONF="$RCLONE_DIR/rclone.conf"
ENCRYPTED_FILE="$RCLONE_DIR/rclone.conf.bkp"

# ID da chave GPG (pode ser email ou fingerprint curta)
GPG_KEY_ID="giovanebribeiro@gmail.com"

# Verifica se o arquivo existe
if [ ! -f "$RCLONE_CONF" ]; then
    echo "Arquivo rclone.conf não encontrado!"
    exit 1
fi

# Criptografa o arquivo
gpg --yes --encrypt --recipient "$GPG_KEY_ID" -o "$ENCRYPTED_FILE" "$RCLONE_CONF"

echo "Arquivo criptografado em: $ENCRYPTED_FILE"

# Para descriptografar:
# gpg -o rclone.conf -d rclone.conf.bak.gpg
