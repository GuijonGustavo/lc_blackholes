#!/bin/sh
# Made by:
# Gustavo Magallanes-Guijón <gustavo.magallanes.guijon@ciencias.unam.mx>
# Instituto de Astronomia UNAM
# Ciudad Universitaria
# Ciudad de Mexico
# Mexico
# Tue Jan 06 15:47:42 UTC 2020
#

awk '{ gsub(/</,""); print }' *.txt > out.csv
echo '#mjd,		flux,	err' > optical.dat
#awk -F "\"*,\"*" '/[0-9]+\.[0-9]*/{print $1 $2 $2/10}' out.csv >> optical.dat
awk -e '/^[0-9]/{print $1-2400000.5"	"$2"	"$2/10}' out.csv >> optical.dat
rm out.csv
