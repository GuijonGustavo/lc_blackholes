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

plot "<(sed -n '3,81148p' hardrat.dat)" using ($1*0.000011570+53350.59793623):4:5 title "Windowed Timing" with yerrorbars lc "blue", \
"<(sed -n '243454,243516p' hardrat.dat)" using ($1*0.000011570+53350.59793623):4:5 title "Photon Counting" with yerrorbars lc "red"

set tmargin 0
set lmargin 10.4
set ylabel "0.3-1.5 keV c/s"
plot "<(sed -n '81156,162301p' hardrat.dat)" using ($1*0.000011570+53350.59793623):4:5 title "Windowed Timing" with yerrorbars lc "blue", \
"<(sed -n '243524,243586p' hardrat.dat)" using ($1*0.000011570+53350.59793623):4:5 title "Photon Counting" with yerrorbars lc "red"

set bmargin 3
set xtics format "%g"
set lmargin 10.4
set xlabel "MJD"
set ylabel "Hard/Soft"
plot "<(sed -n '162309,243448p' hardrat.dat)" using ($1*0.000011570+53350.59793623):4:5 title "Windowed Timing" with yerrorbars lc "blue", \
"<(sed -n '243594,243648p' hardrat.dat)" using ($1*0.000011570+53350.59793623):4:5 title "Photon Counting" with yerrorbars lc "red"

unset multiplot
