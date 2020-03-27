#\!/bin/bash
# Made by:
# Gustavo Magallanes-Guijón <gustavo.magallanes.guijon@ciencias.unam.mx>
# Instituto de Astronomia UNAM
# Ciudad Universitaria
# Ciudad de Mexico
# Mexico

find . -name 'curve.qdp' -print0 | xargs -0 -I {} sed -n '/ WT data$/,/ PC data$/p' {} >> curve.dat
echo "############################################################" >> curve.dat
echo "#/ WT data$/,/ PC data$/ ###################" >> curve.dat
echo "############################################################" >> curve.dat
find . -name 'curve.qdp' -print0 | xargs -0 -I {} sed -n '/ PC data$/,/ \$/p' {} >> curve.dat
echo "############################################################" >> curve.dat
echo "#/ PC data$/,/ $/ ##############" >> curve.dat
echo "############################################################" >> curve.dat
