
from utils.shell_utils import ShellUtils
from utils.pexpect_util import PexpectUtil
from utils.yaml_parser import YmlParser


import logging

# Create and configure logger
logging.basicConfig(filename="data/execution.log",
                    format='%(asctime)s %(message)s',
                    filemode='a+')

# Creating an object
logger = logging.getLogger()

# Setting the threshold of logger to DEBUG
logger.setLevel(logging.DEBUG)

class master_command(object):
    def __init__(self):
        self.obj = ShellUtils()
        self.dict_file = YmlParser().yml_parse()
        self.ssh_user = self.dict_file["ssh_user"]
        self.ssh_password = self.dict_file["ssh_password"]
        self.cdap_master = self.dict_file["cdap_master"]
        self.p_obj = PexpectUtil(self.ssh_user, self.ssh_password)

    def enable_rotation(self,hostname):
        cmd = 'chmod 0644 /etc/logrotate.d/cdap'
        logging.info("Executing command : %s on remote node" % cmd)
        self.p_obj.pxssh_cmd(cmd,hostname)
        cmd = '/usr/sbin/logrotate -d /etc/logrotate.d/cdap'
        logging.info("Executing command : %s" % cmd)
        self.p_obj.pxssh_cmd(cmd,hostname)


    def ranger_jar(self,hostname):
        cmd = "sudo rm -rf /opt/cdap/master/ext/security/*"
        logging.info("Executing command : %s" % cmd)
        self.p_obj.pxssh_cmd(cmd, hostname)
        cmd = "sudo cp /tmp/security/*  /opt/cdap/master/ext/security/"
        logging.info("Executing command : %s" % cmd)
        self.p_obj.pxssh_cmd(cmd, hostname)
        cmd = "sudo chown cdap:cdap -R /opt/cdap/master/ext/security/"
        logging.info("Executing command : %s" % cmd)
        self.p_obj.pxssh_cmd(cmd, hostname)

    def scp_security(self,hostname):
        cmd = "sudo scp -r /tmp/cdap_tar/cdap/security %s@%s:/tmp/" %(self.ssh_user,hostname)
        logging.info("Executing command: %s" % cmd)
        self.p_obj.pexpect_scp(cmd,hostname)

if __name__ == '__main__':


    master_cmd = master_command()
    logging.info("Master nodes are : %s" %master_cmd.cdap_master)

    for i in range(0,len(master_cmd.cdap_master)):
        master_cmd.scp_security(master_cmd.cdap_master[i])
        master_cmd.enable_rotation(master_cmd.cdap_master[i])
        master_cmd.ranger_jar(master_cmd.cdap_master[i])




