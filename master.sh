#!/bin/bash

#TSTART  =           558978321. / mission time of the start of the observation
#TSTOP   =           594087759. / mission time of the end of the observation
#(594087759-558978321)/86400 = 406

#n_max=406 406/5 = 81 numero de observaciones entre clases 
#days=1

#
#(594087759-576807758)/86400 = 200

#if [[ $n == 0]]; then 
#
#mkdir particular 
#mkdir counts 
#mkdir results 
#mkdir time 
#mkdir cube 
#mkdir bin 
#mkdir map 
#mkdir bitacoras 
#
#fi

t_start=558978321
t_stop=594087759
cores=48
bins=1


for (( i=1; i<=$cores; i++ ))
do

touch $src'_'$i.sh
echo "#!/bin/bash" >> $src'_'$i.sh

#$t_dif #406
#$t_cociente #8
#$t_res #22

sc=L200215232030D227484224_SC00.fits
asc=29.5
decli=65.73333333
radio=15

n=$i
t_inc=$(echo "$n * 86400 + $t_start" | bc)
src=frb

t_dif=$(echo "($t_stop - $t_start)/(86400 * $bins)" | bc)
t_cociente=$(echo "$t_dif/$cores" | bc)
t_res=$(echo "$t_dif%$cores" | bc)


echo "while ((n <= "$t_cociente"))" >> $src'_'$i.sh
echo "do" >> $src'_'$i.sh

	echo "t_fin=\$(echo '${t_inc} + 86400' | bc)" >> $src'_'$i.sh

	echo "echo 'Comienza gtselect'" >> $src'_'$i.sh

	echo "gtselect zmax=90 emin=100 emax=300000 infile=@events.txt outfile=${src}_particular_$n.fits ra=$asc dec=$decli rad=$radio evclass=128 tmin=\$t_inc tmax=\$t_fin" >> $src'_'$i.sh

	echo "echo 'listo ${src}_particular_$n.fits'" >> $src'_'$i.sh


 	echo "echo 'Comienza gtmktime'" >> $src'_'$i.sh

echo "if [[ -f ${src}_particular_$n.fits ]]; then" >> $src'_'$i.sh
 
	echo "gtmktime scfile=$sc filter='(DATA_QUAL>0)&&(LAT_CONFIG==1)' roicut=yes evfile=${src}_particular_$n.fits outfile=${src}_time_$n.fits" >> $src'_'$i.sh

	echo "echo 'listo ${src}_time_$n.fits'" >> $src'_'$i.sh

echo "fi" >> $src'_'$i.sh


	echo "echo 'Comienza gtltcube'" >> $src'_'$i.sh
 
echo "if [[ -f ${src}_time_$n.fits ]]; then" >> $src'_'$i.sh
 
	echo "gtltcube evfile=${src}_time_$n.fits scfile=$sc outfile=${src}_cube_$n.fits dcostheta=0.025 binsz=1" >> $src'_'$i.sh
 
	echo "echo 'listo ${src}_cube_$n.fits'" >> $src'_'$i.sh

echo "fi" >> $src'_'$i.sh


	echo "echo 'Comienza gtbin'" >> $src'_'$i.sh
 
echo "if [[ -f ${src}_cube_$n.fits ]]; then" >> $src'_'$i.sh
 
	echo "gtbin evfile=${src}_time_$n.fits scfile=$sc outfile=${src}_bin_$n.fits algorithm=CMAP nxpix=120 nypix=120 binsz=0.25 coordsys=CEL xref=$asc yref=$decli axisrot=0 proj=AIT" >> $src'_'$i.sh

	echo "echo 'listo ${src}_bin_$n.fits'" >> $src'_'$i.sh


echo "fi" >> $src'_'$i.sh


	echo "echo 'Comienza gtexpmap'" >> $src'_'$i.sh

echo "if [[ -f ${src}_bin_$n.fits ]]; then" >> $src'_'$i.sh
 
	echo "gtexpmap evfile=${src}_time_$n.fits scfile=$sc expcube=${src}_cube_$n.fits outfile=${src}_map_$n.fits irfs=P8R3_SOURCE_V2 srcrad=$radio nlong=120 nlat=120 nenergies=20" >> $src'_'$i.sh
 
	echo "echo 'listo ${src}_map_$n.fits'" >> $src'_'$i.sh

echo "fi" >> $src'_'$i.sh

	echo "echo 'Comienza gtdiffrsp'" >> $src'_'$i.sh

echo "the_world_is_flat=true" >> $src'_'$i.sh

echo "if [[ -f ${src}_map_$n.fits ]]; then" >> $src'_'$i.sh

	echo "gtdiffrsp evfile=${src}_time_$n.fits scfile=$sc srcmdl=$src.xml irfs=P8R3_SOURCE_V2" >> $src'_'$i.sh

	echo "the_world_is_flat=false" >> $src'_'$i.sh

	echo "echo 'listo gtdiffrsp'" >> $src'_'$i.sh

echo "fi" >> $src'_'$i.sh


	echo "echo 'Comienza gtlike'" >> $src'_'$i.sh

echo "if [[ \$the_world_is_flat==false ]]; then" >> $src'_'$i.sh

	echo "gtlike irfs=P8R3_SOURCE_V2 expcube=${src}_cube_$n.fits srcmdl=$src.xml statistic=UNBINNED optimizer=MINUIT evfile=${src}_time_$n.fits scfile=$sc expmap=${src}_map_$n.fits > ${src}_bitacora_$n.log" >> $src'_'$i.sh

	echo "echo 'listo gtlike'" >> $src'_'$i.sh


echo "fi" >> $src'_'$i.sh


	echo "echo 'Comienza bitacora'" >> $src'_'$i.sh

echo "if [[ -f ${src}_bitacora_$n.log ]]; then" >> $src'_'$i.sh
 

echo "mv ${src}_particular_$n.fits particular" >> $src'_'$i.sh

echo "mv ${src}_time_$n.fits time" >> $src'_'$i.sh
 
echo "mv ${src}_cube_$n.fits cube" >> $src'_'$i.sh

echo "mv ${src}_bin_$n.fits bin" >> $src'_'$i.sh

echo "mv ${src}_map_$n.fits map" >> $src'_'$i.sh

echo "mv ${src}_bitacora_$n.log bitacoras" >> $src'_'$i.sh

echo "mv counts_spectra.fits counts/counts_spectra_$n.fits" >> $src'_'$i.sh

echo "mv results.dat results/results_$n.dat" >> $src'_'$i.sh


	echo "echo 'Listo bitacora_${src}_$n.log'" >> $src'_'$i.sh

echo "fi" >> $src'_'$i.sh

	echo "((n +=1))" >> $src'_'$i.sh


	echo "\$t_inc =\$t_fin + 86400" >> $src'_'$i.sh

echo "done" >> $src'_'$i.sh

#End While loop

#$t_inc = $t_inc
#$n = $t_cociente+1
#$t_cociente += $n

done
#End for loop
