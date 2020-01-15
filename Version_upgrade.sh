#git submodule foreach --recursive git clean -xfd && \
#git reset --hard  && \
#git submodule foreach --recursive git reset --hard && \
#git submodule update --remote && \
#git submodule update --init --recursive --remote

## declare an array variable
declare -a arrayT=()
for item in `git config --file .gitmodules --get-regexp submodule  | awk '{ print $2 }'`
do
    arrayT+=($item)
done;

#declare -A release_branches
#release_branches[cdap]='release/build_guavus_5.1.2_'
#release_branches[app_artifacts_hydrator_plugins]='release/build_guavus_2.1_'
#release_branches[security_extensions_cdap_security_extn]='release/build_guavus_0.8_'
#release_branches[app_artifacts_mmds]='release/build_guavus_1.1_'
#release_branches[app_artifacts_dre]='release/build_guavus_1.1_'
#release_branches[cdap_ambari_service]='release/build_guavus_5.1_'
#release_branches[sentry]='release/build_guavus_1.7.0_'
#release_branches[app_artifacts_auto_feature_engineering]='release/build_guavus_'
#release_branches[app_artifacts_cdap_mrds]='release/build_guavus_'
#release_branches[app_artifacts_auto_metadata_service]='release/build_guavus_1.0.0_'

# get length of an array
arraylength=${#arrayT[@]}
home_dir=$(pwd)
#echo "$home_dir";

read -p "Enter Old Version: "  old_version
read -p "Enter New Version: "  new_version
echo $new_version;
echo $old_version;
# use for loop to read all values and indexes
for (( i=0; i<${arraylength}; i=i+3 ));
do
  directory="${arrayT[$i]}";
  branch="${arrayT[$i+2]}";
  url="${arrayT[$i+1]}";
  echo $directory;
  case "$directory" in
   "cdap") release_branch='release/build_guavus_5.1.2_'
   ;;
   "app-artifacts/hydrator-plugins") release_branch='release/build_guavus_2.1_'
   ;;
   "security-extensions/cdap-security-extn") release_branch='release/build_guavus_0.8_'
   ;;
   "app-artifacts/mmds") release_branch='release/build_guavus_1.1_'
   ;;
   "app-artifacts/dre") release_branch='release/build_guavus_1.1_'
   ;;
   "cdap-ambari-service") release_branch='release/build_guavus_5.1_'
   ;;
   "sentry") release_branch='release/build_guavus_1.7.0_'
   ;;
   "app-artifacts/auto-feature-engineering") release_branch='release/build_guavus_'
   ;;
   "app-artifacts/cdap-mrds") release_branch='release/build_guavus_'
   ;;
   "app-artifacts/auto-metadata-service") release_branch='release/build_guavus_1.0.0_'
   ;;
   esac
   release_branch="${release_branch}${new_version}"
  echo $release_branch;
  cd $directory;
  git checkout $branch;
  git checkout -b $release_branch;
  grep -lr --include=pom.xml $old_version * | xargs sed -i -e "s/$old_version/$new_version/g";
  find . -name "pom.xml-e" -type f -delete;
  find . -name "*.iml" -type f -delete;
  git add -A;
  git commit -m 'version Changed';
  git push origin --force $release_branch;
  cd $home_dir;
#  echo  " cd $directory; git checkout $branch; echo changeSomething; git add -A; git commit -m 'version changed'; git push ; cd ..; ";

done
