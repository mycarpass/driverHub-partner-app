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



# Executa o comando flutter build ipa
echo -e "${COR_VERDE}Iniciando compilação do IPA...${COR_PADRAO}"
flutter build ipa

# Verifica se a compilação foi bem-sucedida
if [ $? -eq 0 ]; then
    echo -e "${COR_VERDE}Compilação do IPA concluída com sucesso.${COR_PADRAO}"

    # Navega até o diretório android
    cd ios

    # Executa o comando fastlane supply com o caminho para o arquivo aab gerado
    echo -e "${COR_VERDE}Iniciando upload do IPA para o Apple Store...${COR_PADRAO}"
    fastlane beta

    # Verifica se o upload foi bem-sucedido
    if [ $? -eq 0 ]; then
        echo -e "${COR_VERDE}Upload do ipa para o Apple Store concluído com sucesso.${COR_PADRAO}"
    else
        echo -e "${COR_VERMELHA}Erro ao realizar o upload do ipa para o Apple Store.${COR_PADRAO}"
    fi
else
    echo -e "${COR_VERMELHA}Erro ao compilar o ipa.${COR_PADRAO}"
fi
