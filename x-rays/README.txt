# Made by:
# Gustavo Magallanes-Guijón <gustavo.magallanes.guijon@ciencias.unam.mx>
# Instituto de Astronomia UNAM
# Ciudad Universitaria
# Ciudad de Mexico
# Mexico

vim:

%s/!/#!/g
%s/NO/#NO/g
%s/READ/#READ/g

awk. max, min, average:

cat curve.dat | awk -e '/^[0-9]/{if(min==""){min=max=$1}; if($1>max) {max=$1}; if($1<min) {min=$1}; total+=$1; count+=1} END {print "avg " total/count," | max "max," | min " min}'

git:

git pull https://github.com/gustavomagallanesguijon/lc_blackholes.git
git remote add origin https://github.com/gustavomagallanesguijon/lc_blackholes.git
git push origin master

