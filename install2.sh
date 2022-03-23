#!/bin/bash
>mycrontab
exec < zaman_tablosu.csv
while read line
do
   #echo "Record is : $line"
   arr=$(echo $line | tr "," "\n")
   i=0
   kalan=$((i%2))	
   for x in $arr
   do
     if [ $i -eq 0 ]; then

	   if [[ "${x}" == "Pazartesi" ]] ;then
		   hg=0;	
	   elif [[ "${x}" == "Salı" ]] ;then
		   hg=1;
	   elif [[ "${x}" == "Çarşamba" ]] ;then
		   hg=2;
	   elif [[ "${x}" == "Perşembe" ]] ;then
		   hg=3;
	   elif [[ "${x}" == "Cuma" ]] ;then
		   hg=4;
	   elif [[ "${x}" == "Cumartesi" ]] ;then
		   hg=5;
	   elif [[ "${x}" == "Pazar" ]] ;then
		   hg=6;		   
	   fi
	  else 
		zaman=$(echo $x | tr ":" "\n")
		j=0
		for z in $zaman
		do

			 if [ $j -eq 0 ]; then
				saat=$z;
			 elif [ $j -eq 1 ]; then
				dakika=$z
				
				if [[ "${dakika}" == "00" ]] ;then
				
					ogrenci_dakika="58"	
					saat=$((saat=saat-1))
				else 
					ogrenci_dakika=$((dakika-2))
				fi
			   	
				
			 
			 fi
			 
	                ((j=j+1))
		done
                


		#echo "$dakika - $ogrenci_dakika $saat * * $hg $PWD/player.sh $PWD/zil.mp3" 
       		echo "$i Öğretmen: $dakika $saat * * $hg $PWD/player.sh $PWD/zil.mp3"
	
		if [ $((i%2)) -eq 1 ]; then
		  echo "$i Öğrenci zili : $ogrenci_dakika $saat * * $hg $PWD/player.sh $PWD/zil.mp3" 
		fi
	  fi 

	  ((i=i+1))
   done
   

done
#echo "* * * * * mplayer $PWD/zil.mp3" >> mycrontab 
crontab mycrontab
rm mycrontab