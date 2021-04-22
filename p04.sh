#!/bin/bash

function demfitx {
    echo -n "Fitxer dins de /etc/ a comprimir: "
    read fitxer

    ruta_sencera="/etc/"
    ruta_sencera=${ruta_sencera}${fitxer}

    if [ -f $ruta_sencera ]
    then
        sudo cp $ruta_sencera "${ruta_sencera}.orig"
        tar -czvf "{$fitxer}.orig.tar.gz" "${ruta_sencera}.orig"

        file="{$fitxer}.orig.tar.gz"
        echo "mida = $(wc -c <"$file")"
        #echo $size
    else
        echo "Error: El fitxer demanat no existeix"
        exit 1
    fi

    }

if (( EUID != 0 ))
then
  echo "Aquest script s'ha d'executar amb prilegis de l'usuari root"
  exit 1
fi

clear

continuar='s'
while [ $continuar == 's' ]
do
    demfitx
    echo -n "Vols continuar? (0=Si): "
    read trigger
    if [ $trigger != 0 ]
    then
        continuar='f'
    fi
done
exit 15
