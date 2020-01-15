git submodule foreach --recursive git clean -xfd && \
git reset --hard  && \
git submodule foreach --recursive git reset --hard && \
git submodule update --remote && \
git submodule update --init --recursive --remote

## declare an array variable
declare -a arrayT=()
for item in `git config --file .gitmodules --get-regexp submodule  | awk '{ print $2 }'`
do
    arrayT+=($item)
done;

# get length of an array
arraylength=${#arrayT[@]}
home_dir=$(pwd)

# use for loop to read all values and indexes
for (( i=0; i<${arraylength}; i=i+3 ));
do
  directory="${arrayT[$i]}";
  branch="${arrayT[$i+2]}";
  url="${arrayT[$i+1]}";
  cd $directory;
  git checkout $branch;
  grep -lr --include=pom.xml "5.1.217" * | xargs sed -i -e 's/5.1.217/5.1.216/g';
  find . -name "pom.xml-e" -type f -delete;
  find . -name "*.iml" -type f -delete;
  git add -A;
  git commit -m 'version Changed';
  git push origin --force $branch;
  cd $home_dir;
#  echo  " cd $directory; git checkout $branch; echo changeSomething; git add -A; git commit -m 'version changed'; git push ; cd ..; ";

done
