#!/usr/bin/env bash
export MAVEN_OPTS="-Xmx8144m"
mvn clean install -e -P spark1-dev,spark2-dev,templates,dist,release,rpm-prepare,rpm,tgz \
 -Drat.skip -Dcheckstyle.skip -Dmaven.javadoc.skip -Dmaven.source.skip -Dmaven.test.skip -Dgpg.skip \
 -Dadditional.artifacts.dir=$(pwd)/app-artifacts \
 -DbuildNumber=42 \
 -rf :cdap-ui
 $*
