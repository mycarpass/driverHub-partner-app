#!/bin/bash

# Chama o primeiro script
echo "Executando o Script 1..."
./pump_version.sh


# Chama o segundo script
./ios_prod_deploy.sh

./android_prod_deploy.sh
# Se chegou até aqui, todos os scripts foram executados com sucesso
echo "${COR_VERDE} Deploy e ambas as lojas realizados com sucesso"
