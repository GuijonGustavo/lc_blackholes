# Made by:
# Gustavo Magallanes-Guijón <gustavo.magallanes.guijon@ciencias.unam.mx>
# Instituto de Astronomia UNAM
# Ciudad Universitaria
# Ciudad de Mexico
# Mexico

set terminal png size 1280,960
set key autotitle columnhead
set key
set output "mrk421.png"
set title "Fermi/Gamma Mrk 421"
set xlabel "MJD"
set x2data time
set timefmt "%Y-%m-%d"
set format x2 "%Y-%m-%d"
set x2tics
set x2range["2008-08-04":"2020-03-09"]
set ylabel "Count Rate (0.3-10 keV)(c/s)"

plot 'mrk421.dat' using 1:2:3 title "Count Rate (0.3-10 keV)(c/s)" with yerrorbars lc "blue"
