#\!/bin/bash
# Made by:
# Gustavo Magallanes-Guijón <gustavo.magallanes.guijon@ciencias.unam.mx>
# Instituto de Astronomia UNAM
# Ciudad Universitaria
# Ciudad de Mexico
# Mexico

find . -name 'hardrat.qdp' -print0 | xargs -0 -I {} sed -n '/ WT -- hard data$/,/ WT -- soft data$/p' {} >> hardrat.dat
echo "############################################################" >> hardrat.dat
echo "#/ WT -- hard data$/,/ WT -- soft data$/ ###################" >> hardrat.dat
echo "############################################################" >> hardrat.dat
find . -name 'hardrat.qdp' -print0 | xargs -0 -I {} sed -n '/ WT -- soft data$/,/ WT -- hardness ratio$/p' {} >> hardrat.dat
echo "############################################################" >> hardrat.dat
echo "#/ WT -- soft data$/,/ WT -- hardness ratio$/ ##############" >> hardrat.dat
echo "############################################################" >> hardrat.dat
find . -name 'hardrat.qdp' -print0 | xargs -0 -I {} -I {} sed -n '/ WT -- hardness ratio$/,/ PC -- hard data$/p' {} >> hardrat.dat
echo "############################################################" >> hardrat.dat
echo "#/ WT -- hardness ratio$/,/ PC -- hard data$/ ##############" >> hardrat.dat
echo "############################################################" >> hardrat.dat
find . -name 'hardrat.qdp' -print0 | xargs -0 -I {} sed -n '/ PC -- hard data$/,/ PC -- soft data$/p' {} >> hardrat.dat
echo "############################################################" >> hardrat.dat
echo "#/ PC -- hard data$/,/ PC -- soft data$/ ###################" >> hardrat.dat
echo "############################################################" >> hardrat.dat
find . -name 'hardrat.qdp' -print0 | xargs -0 -I {} sed -n '/ PC -- soft data$/,/ PC -- hardness ratio$/p' {} >> hardrat.dat
echo "############################################################" >> hardrat.dat
echo "#/ PC -- soft data$/,/ PC -- hardness ratio$/ ##############" >> hardrat.dat
echo "############################################################" >> hardrat.dat
find . -name 'hardrat.qdp' -print0 | xargs -0 -I {} sed -n '/ PC -- hardness ratio$/,/\$/p' {} >> hardrat.dat
echo "############################################################" >> hardrat.dat
echo "#/ PC -- hardness ratio$/,/\$/ #############################" >> hardrat.dat
echo "############################################################" >> hardrat.dat
