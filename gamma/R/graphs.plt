#para ejecutar el escript en terminal: gnuplot -persist grap.plt
#Aqui va el primer plot. El de los datos en energias de 100Mev a 300GeV
#aavso_mrk421  OPTICO
#
set terminal png size 1280,960
set datafile separator ","
set key autotitle columnhead
set key off
set output "images/gamma_rpt_mrk421.png"
set title "RobPer Periodogram Gamma-rays Mrk 421"
set ylabel ""
set xlabel "Periods (days)"
plot "data/gamma_rpt_mrk421.csv" with lines

#set terminal png size 1280,960
#set datafile separator ","
set key autotitle columnhead
set key off
set output "images/gamma_lomb_mrk421.png"
set title "Lomb-Scargle Periodogram Gamma-rays Mrk 421"
set ylabel "Power"
set xlabel "Scanned"
plot "data/gamma_lomb_mrk421.csv" with impulses lw 4



#set terminal png size 1280,960
#set datafile separator ","
set key autotitle columnhead
set key off
set output "images/gamma_rand_mrk421.png"
set title "Randomise Lomb-Scargle Periodogram Gamma-rays Mrk 421"
set ylabel "Power"
set xlabel "Scanned"
plot "data/gamma_rand_mrk421.csv" with lines


