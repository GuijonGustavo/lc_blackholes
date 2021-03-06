# Made by:
# Gustavo Magallanes-Guijón <gustavo.magallanes.guijon@ciencias.unam.mx>
# Instituto de Astronomia UNAM
# Ciudad Universitaria
# Ciudad de Mexico
# Mexico

set terminal png size 1280,960
set key autotitle columnhead
set key 

unset xlabel
set output "hardrat.png"
unset xlabel
set multiplot layout 3, 1 title "Hardness ratio Mrk 421"
set bmargin 0
set xtics format " "
set ylabel "1.5-10 keV c/s"
set lmargin 10.4

set x2data time
set timefmt "%Y-%m-%d"
set format x2 "%Y-%m-%d"
set x2tics
set x2range["2005-03-01":"2020-04-01"]

plot "<(sed -n '2,81350p' hardrat.dat)" using 1:4:5 title "Windowed Timing" with yerrorbars lc "blue", \
"<(sed -n '244040,244129p' hardrat.dat)" using 1:4:5 title "Photon Counting" with yerrorbars lc "red"

set tmargin 0
set lmargin 10.4
set ylabel "0.3-1.5 keV c/s"
plot "<(sed -n '81350,162705p' hardrat.dat)" using 1:4:5 title "Windowed Timing" with yerrorbars lc "blue", \
"<(sed -n '244137,244226p' hardrat.dat)" using 1:4:5 title "Photon Counting" with yerrorbars lc "red"

set bmargin 3
set xtics format "%g"
set lmargin 10.4
set xlabel "MJD"
set ylabel "Hard/Soft"
plot "<(sed -n '162713,244034p' hardrat.dat)" using 1:4:5 title "Windowed Timing" with yerrorbars lc "blue", \
"<(sed -n '244234,244305p' hardrat.dat)" using 1:4:5 title "Photon Counting" with yerrorbars lc "red"

unset multiplot
