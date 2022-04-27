# create directory with jpg files
mkdir pictures
mv *.JPG pictures
rename 's/JPG/jpg/' *.JPG

# see from which years the files are
ls -l --time-style="+%Y" | tail -n +2 | rev | cut -f 2 -d " " | rev | sort | uniq -c

# this command can also be saved in a script for easy re-use
nano count_years.sh
bash count_years.sh

# create sub directories for each year
bash count_years.sh | rev | cut -f 1 -d " " | rev | xargs mkdir

# manually sort images from 2022
ls -l --time-style="+%Y" *.jpg | rev | cut -f 1,2 -d " " | rev | grep "^2022"
ls -l --time-style="+%Y" *.jpg | rev | cut -f 1,2 -d " " | rev | grep "^2022" | cut -f 2 -d " " | xargs mv -t 2022 
ls 2022

# sort all the other files (look at the commands before executing)
ls -l --time-style="+%Y" *.jpg | tail -n +2 | rev | cut -f 1,2 -d " " | rev | awk '{print "mv " $2 " " $1}'
ls -l --time-style="+%Y" *.jpg | tail -n +2 | rev | cut -f 1,2 -d " " | rev | awk '{print "mv " $2 " " $1}' | bash

# check for duplicate dates (up to seconds)
ls -l --time-style="+%Y-%m-%d_%H-%M-%S" *.jpg | rev | cut -f 1,2 -d " " | rev | cut -f 1 -d " " | sort | uniq -c -d

# a way to get some metadata from images
exiftool IMG_3525.jpg 

# rename files without overwriting
ls -l --time-style="+%Y-%m-%d_%H-%M-%S" *.jpg | rev | cut -f 1,2 -d " " | rev | awk '{print "mv --backup=numbered " $2 " " $1 ".jpg"}' | bash

# rename files to have the count before the .jpg suffix
rename 's/.jpg.~(\d)~/_\1.jpg/' *
