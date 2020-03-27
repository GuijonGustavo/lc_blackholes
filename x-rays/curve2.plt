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
set output "curve2.png"
unset xlabel

set multiplot layout 2, 1 title "Swift/XRT Mrk 421"

set bmargin 0
set xtics format " "
set lmargin 10
set ylabel "Count Rate (0.3-10 keV) (s^-1)" # \n{/*0.8 Photon Counting Source}"

plot "<(sed -n '2,160031p' curve2.dat)" using ($1*0.000011570+53350.59793623):4:5:6 title "Windowed Timing (source)" with yerrorbars lc "blue", \
"<(sed -n '160036,$p' curve2.dat)" using ($1*0.000011570+53350.59793623):4:5:6 title "Photon Counting (source)" with yerrorbars lc "red"

set tmargin 0
set bmargin 3
set xtics format "%g"
set lmargin 10
set xlabel "MJD"
set ylabel "FracExp" # \n{/*0.8 Photon Counting Background}"


plot "<(sed -n '2,160031p' curve2.dat)" using ($1*0.000011570+53350.59793623):7:8:9 title "Windowed Timing (background)" with yerrorbars lc "pink", \
"<(sed -n '160036,$p' curve2.dat)" using ($1*0.000011570+53350.59793623):7:8:9 title "Photon Counting (background)" with yerrorbars lc "green"

unset multiplot



