#!/bin/bash
# Made by:
# Gustavo Magallanes-Guijón <gustavo.magallanes.guijon@ciencias.unam.mx>
# Instituto de Astronomia UNAM
# Ciudad Universitaria
# Ciudad de Mexico
# Mexico


#BEGIN USER

t_start=TIME_START
t_stop=TIME_END
cores=48 #CORES. FOR DEFAULT IS 48
bins=1 #BINS. FOR DEFAULT IS 1
src=NAME_OF_OBJECT 
sc=SPACECRAFTFILE.fits
asc=RIGH_ASCENCION
decli=DECLINATION
radio=15 #RADIUS. FOR DEFAULT IS 15

#END USER

#MAKE DIRS AND GEEK FILE

mkdir particular 
mkdir counts 
mkdir results 
mkdir time 
mkdir cube 
mkdir bin 
mkdir map 
mkdir bitacoras 
touch 'geek'

#CALULATE INTERVALS

t_dif=$(echo "($t_stop - $t_start)/(86400 * $bins)" | bc)
t_cociente=$(echo "$t_dif/$cores" | bc)
t_res=$(echo "$t_dif%$cores" | bc)

k=$t_cociente
first=$t_start

#CREATE i FILES

j=1
for (( i=1; i<=$cores+1; i++ ))
do
    echo  "./${src}_${i}.sh" >> 'geek'
    touch $src'_'$i.sh
    chmod u+x $src'_'$i.sh
    echo "#!/bin/bash" >> $src'_'$i.sh
    echo "# Made by:" >> $src'_'$i.sh
    echo "# Gustavo Magallanes-Guijón <gustavo.magallanes.guijon@ciencias.unam.mx>" >> $src'_'$i.sh
    echo "# Instituto de Astronomia UNAM" >> $src'_'$i.sh
    echo "# Ciudad Universitaria" >> $src'_'$i.sh
    echo "# Ciudad de Mexico" >> $src'_'$i.sh
    echo "# Mexico" >> $src'_'$i.sh
    
    echo "t_inc=${first}" >> $src'_'$i.sh
    echo "n=$j" >> $src'_'$i.sh
    echo "m=$k" >> $src'_'$i.sh
    echo "while ((n<=m))" >> $src'_'$i.sh
    echo "do" >> $src'_'$i.sh
    
        echo "    t_fin=\$(echo \"\$t_inc + 86400\" | bc)" >> $src'_'$i.sh
        echo "    echo \"Comienza gtselect\"" >> $src'_'$i.sh
        echo "    gtselect zmax=90 emin=100 emax=300000 infile=@events.txt outfile=${src}_particular_\$n.fits ra=$asc dec=$decli rad=$radio evclass=128 tmin=\$t_inc tmax=\$t_fin" >> $src'_'$i.sh
        echo "    echo \"listo ${src}_particular_\$n.fits\"" >> $src'_'$i.sh
        echo "    echo \$t_inc" >> $src'_'$i.sh
        echo "    echo \$t_fin" >> $src'_'$i.sh
        echo "    echo \"Comienza gtmktime\"" >> $src'_'$i.sh
        echo "    if [[ -f ${src}_particular_\$n.fits ]]; then" >> $src'_'$i.sh
        echo "    gtmktime scfile=$sc filter=\"(DATA_QUAL>0)&&(LAT_CONFIG==1)\" roicut=yes evfile=${src}_particular_\$n.fits outfile=${src}_time_\$n.fits" >> $src'_'$i.sh
        echo "    echo \"listo ${src}_time_\$n.fits\"" >> $src'_'$i.sh
        echo "    fi" >> $src'_'$i.sh
        echo "    echo \"Comienza gtltcube\"" >> $src'_'$i.sh
        echo "    if [[ -f ${src}_time_\$n.fits ]]; then" >> $src'_'$i.sh
        echo "    gtltcube evfile=${src}_time_\$n.fits scfile=$sc outfile=${src}_cube_\$n.fits dcostheta=0.025 binsz=1" >> $src'_'$i.sh
        echo "    echo \"listo ${src}_cube_\$n.fits\"" >> $src'_'$i.sh
        echo "    fi" >> $src'_'$i.sh
        echo "    echo \"Comienza gtbin\"" >> $src'_'$i.sh
        echo "    if [[ -f ${src}_cube_\$n.fits ]]; then" >> $src'_'$i.sh
        echo "    gtbin evfile=${src}_time_\$n.fits scfile=$sc outfile=${src}_bin_\$n.fits algorithm=CMAP nxpix=120 nypix=120 binsz=0.25 coordsys=CEL xref=$asc yref=$decli axisrot=0 proj=AIT" >> $src'_'$i.sh
        echo "    echo \"listo ${src}_bin_\$n.fits\"" >> $src'_'$i.sh
        echo "    fi" >> $src'_'$i.sh
        echo "    echo \"Comienza gtexpmap\"" >> $src'_'$i.sh
        echo "    if [[ -f ${src}_bin_\$n.fits ]]; then" >> $src'_'$i.sh
        echo "    gtexpmap evfile=${src}_time_\$n.fits scfile=$sc expcube=${src}_cube_\$n.fits outfile=${src}_map_\$n.fits irfs=P8R3_SOURCE_V2 srcrad=$radio nlong=120 nlat=120 nenergies=20" >> $src'_'$i.sh
        echo "    echo \"listo ${src}_map_\$n.fits\"" >> $src'_'$i.sh
        echo "    fi" >> $src'_'$i.sh
        echo "    echo \"Comienza gtdiffrsp\"" >> $src'_'$i.sh
        echo "    the_world_is_flat=true" >> $src'_'$i.sh
        echo "    if [[ -f ${src}_map_\$n.fits ]]; then" >> $src'_'$i.sh
        echo "    gtdiffrsp evfile=${src}_time_\$n.fits scfile=$sc srcmdl=$src.xml irfs=P8R3_SOURCE_V2" >> $src'_'$i.sh
        echo "    the_world_is_flat=false" >> $src'_'$i.sh
        echo "    echo \"listo gtdiffrsp\"" >> $src'_'$i.sh
        echo "    fi" >> $src'_'$i.sh
        echo "    echo \"Comienza gtlike\"" >> $src'_'$i.sh
        echo "    if [[ \$the_world_is_flat==false ]]; then" >> $src'_'$i.sh
        echo "    gtlike irfs=P8R3_SOURCE_V2 expcube=${src}_cube_\$n.fits srcmdl=$src.xml statistic=UNBINNED optimizer=MINUIT evfile=${src}_time_\$n.fits scfile=$sc expmap=${src}_map_\$n.fits > ${src}_bitacora_\$n.log" >> $src'_'$i.sh
        echo "    echo \"listo gtlike\"" >> $src'_'$i.sh
        echo "    fi" >> $src'_'$i.sh
        echo "    echo 'Comienza bitacora'" >> $src'_'$i.sh
        echo "    if [[ -f ${src}_bitacora_\$n.log ]]; then" >> $src'_'$i.sh
        echo "    mv ${src}_particular_\$n.fits particular" >> $src'_'$i.sh
        echo "    mv ${src}_time_\$n.fits time" >> $src'_'$i.sh
        echo "    mv ${src}_cube_\$n.fits cube" >> $src'_'$i.sh
        echo "    mv ${src}_bin_\$n.fits bin" >> $src'_'$i.sh
        echo "    mv ${src}_map_\$n.fits map" >> $src'_'$i.sh
        echo "    mv ${src}_bitacora_\$n.log bitacoras" >> $src'_'$i.sh
        echo "    mv counts_spectra.fits counts/counts_spectra_\$n.fits" >> $src'_'$i.sh
        echo "    mv results.dat results/results_\$n.dat" >> $src'_'$i.sh
        echo "    echo 'Listo bitacora_${src}_\$n.log'" >> $src'_'$i.sh
        echo "    fi" >> $src'_'$i.sh
        echo "    ((n+=1))" >> $src'_'$i.sh
        echo "    ((t_inc=\$t_fin + 1))" >> $src'_'$i.sh
    echo "done" >> $src'_'$i.sh
    
    ((j+=$t_cociente))
    ((k+=$t_cociente))
    ((t_start+=86400))
    
    #ADD AN UNIT FOR INTERVALES DON'T FOLDING
    ((first+=(86400+1)*$t_cociente))
    
done