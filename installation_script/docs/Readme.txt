############################################################
###### Script is used to run ambari commands from shell ####
############################################################


In Upgrade doc all the command in section 6 Enabling Configurations will be executed with this script.
section 6.3 didn't encorporated as it is already done when installing CDAP



1. To change configuration according to setup -
   i) Open file data/config.yml -
      vi data/config.yml

   ii) Change configuration according to setup mostly setup related configuration will be -
       hive.server2.jdbc.url
       ambari_host
       node_cluster_name
       ambari_admin_user
       ambari_admin_password
       program.container.dist.jars    
       
       and Ldap configuration according to setup

2. To run scipt you need to execute command -

   python test_install.py

3. Logs can be seen at path -

   data/execution.log

4. After running script restart cdap service
