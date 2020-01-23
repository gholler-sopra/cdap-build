############################################################
###### Script is used to run ambari commands from shell ####
############################################################


Prerequisite:

Below python packages are used in script -
1. yaml
2. subprocess
3. getpass
4. logging
5. pexpect

It works on python2.7

Install :
In Upgrade doc all the command in section 6 Enabling Configurations will be executed with this script.


1. To change configuration according to setup -
   i) Open file data/config.yml -
      vi data/config.yml

   ii) Change configuration according to setup mostly setup related configuration will be -
       hive.server2.jdbc.url - hive jbdc url
       node_cluster_name - ambari cluster name
       program.container.dist.jars - comma (,) seperated keytabs in namespaces used
       cdap_master  - list of cdap nodes
       ssh_user     - for cdap nodes
       ssh_password - for cdap nodes
       install_env -> It takes two values dev or prod . If installing on guavus environment give value as "dev". If installing on
       JIO environment give value as "prod".

2. Command line argument are ambari username, ambari password and ambari hostname.

3. To run scipt you need to execute command -

   python test_install.py

4. Run below script for enabling log rotation on cdap nodes and copying ranger jars to path /opt/cdap/master/ext/security/   ->

   python master_command.py

5. Logs can be seen at path -

   data/execution.log