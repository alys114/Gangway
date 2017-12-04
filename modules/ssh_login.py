# Author: Vincent.chan
# Blog: http://blog.alys114.com


import base64
import getpass
import os
import socket
import sys
import traceback
from paramiko.py3compat import input
from  modules import models
import datetime

import paramiko
try:
    import interactive
except ImportError:
    from . import interactive


def ssh_login(user_obj,bind_host_obj,mysql_engine,log_recording):
    # now, connect and use paramiko Client to negotiate SSH2 across the connection
    try:
        client = paramiko.SSHClient()
        client.load_system_host_keys()
        client.set_missing_host_key_policy(paramiko.WarningPolicy())
        print('*** Connecting...')
        #client.connect(hostname, port, username, password)
        client.connect(bind_host_obj.host.ip,
                       bind_host_obj.host.port,
                       bind_host_obj.remote_user.username,
                       bind_host_obj.remote_user.password,
                       timeout=30)

        cmd_caches = []
        chan = client.invoke_shell()
        print(repr(client.get_transport()))
        print('*** Here we go!\n')
        cmd_caches.append(models.AuditLog(user_profile_id=user_obj.id,
                                          bind_host_id=bind_host_obj.id,
                                          action_type='login',
                                          op_date=datetime.datetime.now()
                                          ))
        log_recording(user_obj, bind_host_obj, cmd_caches)
        interactive.interactive_shell(chan,user_obj,bind_host_obj,cmd_caches,log_recording)

        chan.close()
        client.close()

    except Exception as e:
        print('*** Caught exception: %s: %s' % (e.__class__, e))
        traceback.print_exc()
        try:
            client.close()
        except:
            pass
        sys.exit(1)