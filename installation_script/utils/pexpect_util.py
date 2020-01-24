import pexpect

class PexpectUtil(object):

    def __init__(self, ssh_user , ssh_password):
        self.ssh_user = ssh_user
        self.ssh_password = ssh_password


    def pexpect_cmd(self,cmd, ssh_hostname):

        child = pexpect.spawn('ssh -o StrictHostKeyChecking=no %s@%s' %(self.ssh_user, ssh_hostname))
        child.logfile = open("data/remote.log", "a+")
        try:
            child.expect ('password: ')
            child.sendline(self.ssh_password)
        except:
            child.expect ('$')
        child.expect('$')
        child.sendline(cmd)
        child.expect('$')
        child.sendline('exit')
        child.expect('$')