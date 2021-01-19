#!/usr/bin/env bash

# entries2network.sh - given a list of configured cities, output an edges table

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# December 21, 2020 - "Happy Winter"



# configure
HEADER='source\ttarget\tweight'
DB='./etc/tokens.db'
TEMPLATE='.mode tabs\nSELECT "##REGION##", "##CITY##", COUNT( gloss ) FROM tokens WHERE (gloss IS "##CITY##" AND did LIKE "##REGION##%" );'
CITIES=("Abdo;Abduh" "Akha" "Aleppo" "Algeria" "Andalusia" "Ankara" "Anwar" "Aoun" "Aqeel" "Arafa" "Asia" "Azerbeijan" "Baalbakki" "Baalbek" "Badajoz" "Badie" "Baghdad" "Baghdadi" "Bahriz" "Bakri" "Banias;Banyas" "Basra" "Basri" "Beit" "Biruni;Birouni" "Bishi" "Boushi" "Bukhari" "Cairo" "Canaan" "Constantinople" "Cordoba" "Crescent" "Damascus" "Damascus_(old_name)" "Damietta" "Deir" "Dhahab;Zahab" "Egypt" "Euphrates" "Farah" "Farid" "Farouq" "Fayyoum" "Fez;Fes" "Gaul" "Gaza" "Giyath" "Granada" "Greece" "Greeks" "Hama" "Hamdan" "Hamdein;Hamdeen;Hamdain" "Hameeda;Hamida" "Hammad" "Hamza" "Hanaa" "Hauran" "Hebron" "Hejaz" "Helwan_(Egy.)" "Herat_(Afgh.)" "Homs_(Syr.)" "Idris;Edris" "India" "Iraq" "Isfahan" "Israel" "Italy" "Jabbar" "Jazeera" "Jazz" "Jerusalem" "Jubayr" "Kahhal" "Khamis" "Khayyat" "Khurasan" "Lee;Li" "Luhaiya_(Yem.)" "Maher;Mahir" "Mahfouz" "Mali" "Marrakech" "Mawsili" "Mecca" "Mina_(valley_near_Mecca)" "Morocco" "Mosul_(Iraq)" "Muhaya;Muhayya" "Muhsin" "Munajjim" "Murcia" "Murqus" "Nabil" "Quraish" "Ram" "Redwan;Radwan" "Riyadh" "Rizq" "Rukn" "Saadoun" "Saeb;Sa'ib" "Sana';Sanaa" "Saragossa;Zaragoza" "Seville" "Shams" "Sharaf" "Shibh;Shibah" "Shihab;Chihab" "Sinai" "Sind" "Syria" "Talha" "Tayfour" "Tlemcen" "Toledo" "Umran" "Valencia" "Yemen" "Zubair;Zubeir")

# sanity check
if [[ -z $1 ]]; then
	echo "Usage: $0 <Egypt|Syria|Iraq>" >&2
	exit
fi

# get input
REGION=$1

# initialize output
echo -e $HEADER

# process each city
for CITY in ${CITIES[@]}; do

	# create a query and submit it
	SQL=$( echo -e "$TEMPLATE" | sed "s/##CITY##/$CITY/g" | sed "s/##REGION##/$REGION/g")
	echo -e "$SQL" | sqlite3 $DB

# fini
done
exit
