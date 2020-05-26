# Made by:
# Gustavo Magallanes-Guijón <gustavo.magallanes.guijon@ciencias.unam.mx>
# Instituto de Astronomia UNAM
# Ciudad Universitaria
# Ciudad de Mexico
# Mexico

set terminal png size 1280,960
set key autotitle columnhead
set key 
set output "optical.png"
set title "AAVSO/OPTICAL Mrk 421"
set xlabel "MJD"
set x2data time
set timefmt "%Y-%m-%d"
set format x2 "%Y-%m-%d"
set x2tics
set x2range["1984-05-22":"2020-04-13"]
set ylabel "MAGNITUDE"

plot 'optical.dat' using 1:2:3 title "Magnitude" with yerrorbars lc "blue"
