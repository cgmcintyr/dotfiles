import subprocess
import os

BASE_PATH = os.path.join(os.path.expanduser('~'), '.passwords')

def mailpasswd(account):
    path = os.path.join(BASE_PATH, "mail-{}.gpg".format(account))
    return subprocess.check_output(["gpg2", "-d", path]).strip()
