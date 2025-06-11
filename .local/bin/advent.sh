#!/bin/bash

# Caminho do arquivo a ser criado/removido
ARQUIVO="/tmp/advento.txt"

# Data atual
HOJE=$(date +%Y-%m-%d)
ANO=$(date +%Y)

# Calcula o dia da semana do Natal (0=domingo ... 6=sábado)
DIA_SEMANA_NATAL=$(date -d "${ANO}-12-25" +%w)

# Calcula quantos dias voltar desde o Natal até o 4º domingo antes
DIAS_DESDE_ADVENTO=$((28 + DIA_SEMANA_NATAL))

# Calcula a data de início do Advento
DATA_ADVENTO=$(date -d "${ANO}-12-25 -${DIAS_DESDE_ADVENTO} days" +%Y-%m-%d)

# Fim do período: 06 de janeiro do ano seguinte
DATA_FIM=$(date -d "$((ANO + 1))-01-06" +%Y-%m-%d)

# Verifica se hoje está no intervalo [DATA_ADVENTO, DATA_FIM]
if [[ "$HOJE" > "$DATA_ADVENTO" && "$HOJE" < "$DATA_FIM" ]] || [[ "$HOJE" == "$DATA_ADVENTO" || "$HOJE" == "$DATA_FIM" ]]; then
	#echo "estamos no advento"
    [[ -f "$ARQUIVO" ]] || echo "🌟 Tempo do Advento! 🎄" > "$ARQUIVO"
else
	#echo "não estamos no advento"
    [[ -f "$ARQUIVO" ]] && rm -f "$ARQUIVO"
fi

