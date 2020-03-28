# Made by:
# Gustavo Magallanes-Guijón <gustavo.magallanes.guijon@ciencias.unam.mx>
# Instituto de Astronomia UNAM
# Ciudad Universitaria
# Ciudad de Mexico
# Mexico

set terminal png size 1280,960
set key autotitle columnhead
set key 
set output "curve.png"
set title "Swift/XRT Mrk 421"
set xlabel "MJD"
set x2data time
set timefmt "%Y-%m-%d"
set format x2 "%Y-%m-%d"
set x2tics
set x2range["2004-12-11":"2019-06-22"]
set ylabel "Count Rate (0.3-10 keV)(c/s)"

plot "<(sed -n '3,160040p' curve.dat)" using ($1*0.000011570+53350.59793623):4:5:6 title "Windowed Timing" with yerrorbars lc "blue", \
"<(sed -n '160046,$p' curve.dat)" using ($1*0.000011570+53350.59793623):4:5:6 title "Photon Counting" with yerrorbars lc "red"
