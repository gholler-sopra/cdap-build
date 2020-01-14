#!/bin/bash
## declare an array variable
declare -a arrayT=()
for item in `git config --file .gitmodules --get-regexp submodule  | awk '{ print $2 }'`
do
    arrayT+=($item)
done;

# get length of an array
arraylength=${#arrayT[@]}

# use for loop to read all values and indexes
for (( i=0; i<${arraylength}; i=i+3 ));
do
  directory="${arrayT[$i]}";
  branch="${arrayT[$i+2]}";
  url="${arrayT[$i+1]}";
  cd $directory;
  grep -lr --include=pom.xml "5.1.216" * | xargs sed -i -e 's/5.1.216/5.1.217/g';
  find . -name "pom.xml-e" -type f -delete;
  find . -name "*.iml" -type f -delete;
  git checkout $branch;
  git checkout -b dev/RAFD-3635
  git add --all;
  git commit -m 'version Changed';
  git push origin dev/RAFD-3635;
#  git branch;
  pwd
  cd ..;
#  echo  " cd $directory; git checkout $branch; echo changeSomething; git add -A; git commit -m 'version changed'; git push ; cd ..; ";

done
