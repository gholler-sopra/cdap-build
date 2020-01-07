from utils.shell_utils import ShellUtils
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

class CommandUtil(object):



    def __init__(self):

        self.filename = 'data/config.yml'
        self.dict_file = self.config_read()
        self.ambari_port = self.dict_file['ambari_port']
        self.node_cluster_name = self.dict_file['node_cluster_name']
        self.protocol_value = self.dict_file['protocol_value']
        self.ambari_admin_user = self.dict_file['ambari_admin_user']
        self.ambari_admin_password = self.dict_file['ambari_admin_password']
        self.ambari_host = self.dict_file['ambari_host']
        self.cdap_site = self.dict_file['config']['cdap-site']
        self.cdap_security = self.dict_file['config']['cdap-security']


    def execute_test(self):
        obj = ShellUtils()
        for k in self.dict_file['config']:
            for key, value in self.dict_file['config'][k].items():

                if value:
                    cmd = "/var/lib/ambari-server/resources/scripts/configs.py -t %s -s %s -a set -u %s -p %s -l %s -n %s -c %s -k %s -v %s" %(self.ambari_port,self.protocol_value,self.ambari_admin_user,self.ambari_admin_password,self.ambari_host,self.node_cluster_name,k,key,value)
                    logging.info("Executing command : %s" %cmd)

                    response = obj.shell_command(cmd)
                    logging.error("Error while executing is %s" %response.stderr)
                    logging.debug("Stdout while executing is %s" %response.stdout)
                    logging.info("Response code of command executed is %s" %response.status_code)
                    logging.debug("Complete response is %s" %response)


        return response

    def config_read(self):

        response = YmlParser().yml_parse(self.filename)
        return response