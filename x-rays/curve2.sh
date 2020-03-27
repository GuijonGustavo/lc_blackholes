#\!/bin/bash
# Made by:
# Gustavo Magallanes-Guijón <gustavo.magallanes.guijon@ciencias.unam.mx>
# Instituto de Astronomia UNAM
# Ciudad Universitaria
# Ciudad de Mexico
# Mexico

find . -name 'curve2.qdp' -print0 | xargs -0 -I {} sed -n '/ WT data$/,/ PC data$/p' {} >> curve2.dat
echo "############################################################" >> curve2.dat
echo "#/ WT data$/,/ PC data$/ ###################" >> curve2.dat
echo "############################################################" >> curve2.dat
find . -name 'curve2.qdp' -print0 | xargs -0 -I {} sed -n '/ PC data$/,/ \$/p' {} >> curve2.dat
echo "############################################################" >> curve2.dat
echo "#/ PC data$/,/ $/ ##############" >> curve2.dat
echo "############################################################" >> curve2.dat
