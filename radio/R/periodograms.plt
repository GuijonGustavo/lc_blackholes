# Made by:
# Gustavo Magallanes-Guijón <gustavo.magallanes.guijon@ciencias.unam.mx>
# Instituto de Astronomia UNAM
# Ciudad Universitaria
# Ciudad de Mexico
# Mexico

set terminal png size 1280,960
set datafile separator ","
set key autotitle columnhead
set key off
set output "radio_rpt_mrk421.png"
set title "RobPer OVRO/RADIO 40m Mrk421"
set xlabel "Period (days)"
set ylabel "Coeficient of determination"
plot "radio_rpt_mrk421.csv" using 1:2 smooth csplines#impulses#using 1:2:3 with yerrorbars#with impulses 

#####################################

set datafile separator ","
set key autotitle columnhead
set key off
set output "radio_lomb_mrk421.png"
set title "LombScargle OVRO/RADIO 40m Mrk421"
set xlabel "Period (days)"
set ylabel "Coeficient of determination"
set samples 800
plot "radio_lomb_mrk421.csv" using 1:2 smooth csplines#with impulses 


