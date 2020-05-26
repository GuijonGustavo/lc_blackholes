#para ejecutar el escript en terminal: gnuplot -persist grap.plt
#Aqui va el primer plot. El de los datos en energias de 100Mev a 300GeV
#aavso_mrk421  OPTICO

set terminal png size 1280,960
set datafile separator "\t"
set key autotitle columnhead
set key off
set output "radio.png"
set title "Window Function Radio Mrk 421"
set xlabel "Period (days)"
set ylabel "W"
plot "mrk421_radio.dat" using 1:2 with impulses 

