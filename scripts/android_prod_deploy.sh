#!/bin/bash

# Cores ANSI
#!/bin/bash

# Arte ASCII "DriverHub"
DRIVERHUB="
#     ###              ##                                         ###               ### #
#      ##                                                          ##                ## #
#      ##   ######    ###     ##  ##    ####    ######             ##      ##  ##    ## #
#   #####    ##  ##    ##     ##  ##   ##  ##    ##  ##            #####   ##  ##    ##### #
#  ##  ##    ##        ##     ##  ##   ######    ##                ##  ##  ##  ##    ##  ## #
#  ##  ##    ##        ##      ####    ##        ##                ##  ##  ##  ##    ##  ## #
#   ######  ####      ####      ##      #####   ####              ###  ##   ######  ###### #

"

# Cores ANSI
COR_VERDE='\033[0;32m'
COR_VERMELHA='\033[0;31m'
COR_PADRAO='\033[0m'

echo -e "${COR_VERDE}${DRIVERHUB}Iniciando script...${COR_PADRAO}"

# Restante do seu script...

cd ..

# Executa o comando flutter build appbundle
echo -e "${COR_VERDE}Iniciando compilação do appbundle...${COR_PADRAO}"
flutter build appbundle

# Verifica se a compilação foi bem-sucedida
if [ $? -eq 0 ]; then
    echo -e "${COR_VERDE}Compilação do appbundle concluída com sucesso.${COR_PADRAO}"

    # Navega até o diretório android
    cd android

    # Executa o comando fastlane supply com o caminho para o arquivo aab gerado
    echo -e "${COR_VERDE}Iniciando upload do appbundle para o Google Play...${COR_PADRAO}"
    fastlane supply --aab ../build/app/outputs/bundle/release/app-release.aab

    # Verifica se o upload foi bem-sucedido
    if [ $? -eq 0 ]; then
        echo -e "${COR_VERDE}Upload do appbundle para o Google Play concluído com sucesso.${COR_PADRAO}"
    else
        echo -e "${COR_VERMELHA}Erro ao realizar o upload do appbundle para o Google Play.${COR_PADRAO}"
    fi
else
    echo -e "${COR_VERMELHA}Erro ao compilar o appbundle.${COR_PADRAO}"
fi
