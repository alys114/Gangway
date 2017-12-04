# Author: Vincent.chan
# Blog: http://blog.alys114.com


from modules import ssh_login,models
from conf import settings
from modules.utils import print_err
from modules.db_conn import engine,session
def syncdb(argvs):
    print("Syncing DB....")
    engine = models.create_engine(settings.ConnParams,
                          echo=True )
    models.Base.metadata.create_all(engine) #创建所有表结构


#
# def create_hosts(argvs):
#     '''
#     create hosts
#     :param argvs:
#     :return:
#     '''
#     if '-f' in argvs:
#         hosts_file  = argvs[argvs.index("-f") +1 ]
#     else:
#         print_err("invalid usage, should be:\ncreate_hosts -f <the new hosts file>",quit=True)
#     source = yaml_parser(hosts_file)
#     if source:
#         print(source)
#         for key,val in source.items():
#             print(key,val)
#             obj = models.Host(hostname=key,ip=val.get('ip'), port=val.get('port') or 22)
#             session.add(obj)
#         session.commit()
#
#
# def create_remoteusers(argvs):
#     '''
#     create remoteusers
#     :param argvs:
#     :return:
#     '''
#     if '-f' in argvs:
#         remoteusers_file  = argvs[argvs.index("-f") +1 ]
#     else:
#         print_err("invalid usage, should be:\ncreate_remoteusers -f <the new remoteusers file>",quit=True)
#     source = yaml_parser(remoteusers_file)
#     if source:
#         for key,val in source.items():
#             print(key,val)
#             obj = models.RemoteUser(username=val.get('username'),auth_type=val.get('auth_type'),password=val.get('password'))
#             session.add(obj)
#         session.commit()
#
#
# def create_users(argvs):
#     '''
#     create little_finger access user
#     :param argvs:
#     :return:
#     '''
#     if '-f' in argvs:
#         user_file  = argvs[argvs.index("-f") +1 ]
#     else:
#         print_err("invalid usage, should be:\ncreateusers -f <the new users file>",quit=True)
#
#     source = yaml_parser(user_file)
#     if source:
#         for key,val in source.items():
#             print(key,val)
#             obj = models.UserProfile(username=key,password=val.get('password'))
#             # if val.get('groups'):
#             #     groups = session.query(models.Group).filter(models.Group.name.in_(val.get('groups'))).all()
#             #     if not groups:
#             #         print_err("none of [%s] exist in group table." % val.get('groups'),quit=True)
#             #     obj.groups = groups
#             # if val.get('bind_hosts'):
#             #     bind_hosts = common_filters.bind_hosts_filter(val)
#             #     obj.bind_hosts = bind_hosts
#             #print(obj)
#             session.add(obj)
#         session.commit()
#
# def create_groups(argvs):
#     '''
#     create groups
#     :param argvs:
#     :return:
#     '''
#     if '-f' in argvs:
#         group_file  = argvs[argvs.index("-f") +1 ]
#     else:
#         print_err("invalid usage, should be:\ncreategroups -f <the new groups file>",quit=True)
#     source = yaml_parser(group_file)
#     if source:
#         for key,val in source.items():
#             print(key,val)
#             obj = models.HostGroup(name=key)
#             # if val.get('bind_hosts'):
#             #     bind_hosts = common_filters.bind_hosts_filter(val)
#             #     obj.bind_hosts = bind_hosts
#             #
#             # if val.get('user_profiles'):
#             #     user_profiles = common_filters.user_profiles_filter(val)
#             #     obj.user_profiles = user_profiles
#             session.add(obj)
#         session.commit()
#
#
#
# def create_bindhosts(argvs):
#     '''
#     create bind hosts
#     :param argvs:
#     :return:
#     '''
#     if '-f' in argvs:
#         bindhosts_file  = argvs[argvs.index("-f") +1 ]
#     else:
#         print_err("invalid usage, should be:\ncreate_hosts -f <the new bindhosts file>",quit=True)
#     source = yaml_parser(bindhosts_file)
#     if source:
#         for key,val in source.items():
#             #print(key,val)
#             host_obj = session.query(models.Host).filter(models.Host.hostname==val.get('hostname')).first()
#             assert host_obj
#             for item in val['remote_users']:
#                 print(item )
#                 assert item.get('auth_type')
#                 if item.get('auth_type') == 'ssh-password':
#                     remoteuser_obj = session.query(models.RemoteUser).filter(
#                                                         models.RemoteUser.username==item.get('username'),
#                                                         models.RemoteUser.password==item.get('password')
#                                                     ).first()
#                 else:
#                     remoteuser_obj = session.query(models.RemoteUser).filter(
#                                                         models.RemoteUser.username==item.get('username'),
#                                                         models.RemoteUser.auth_type==item.get('auth_type'),
#                                                     ).first()
#                 if not remoteuser_obj:
#                     print_err("RemoteUser obj %s does not exist." % item,quit=True )
#                 bindhost_obj = models.BindHost(host_id=host_obj.id,remoteuser_id=remoteuser_obj.id)
#                 session.add(bindhost_obj)
#                 #for groups this host binds to
#                 if source[key].get('groups'):
#                     group_objs = session.query(models.HostGroup).filter(models.HostGroup.name.in_(source[key].get('groups') )).all()
#                     assert group_objs
#                     print('groups:', group_objs)
#                     bindhost_obj.host_groups = group_objs
#                 #for user_profiles this host binds to
#                 if source[key].get('user_profiles'):
#                     userprofile_objs = session.query(models.UserProfile).filter(models.UserProfile.user_name.in_(
#                         source[key].get('user_profiles')
#                     )).all()
#                     assert userprofile_objs
#                     print("userprofiles:",userprofile_objs)
#                     bindhost_obj.user_profiles = userprofile_objs
#                 #print(bindhost_obj)
#         session.commit()

def auth():
    '''
    do the user login authentication
    :return:
    '''
    count = 0
    while count <3:
        username = input("\033[32;1mUsername:\033[0m").strip()
        if len(username) ==0:continue
        password = input("\033[32;1mPassword:\033[0m").strip()
        if len(password) ==0:continue
        user_obj = session.query(models.UserProfile).filter(models.UserProfile.username==username,
                                                            models.UserProfile.password==password).first()
        if user_obj:
            return user_obj
        else:
            print("wrong username or password, you have %s more chances." %(3-count-1))
            count +=1
    else:
        print_err("too many attempts.")

def welcome_msg(user):
    WELCOME_MSG = '''\033[32;1m------------- Welcome [%s] login ganway -------------\033[0m'''%  user.username
    print(WELCOME_MSG)


def display_access_host(user):
    bindhost_ids = []
    print('bind_host(%s):'%len(user.bind_hosts))
    for h in user.bind_hosts:
        print('|-- [%s],%s@%s ' % (h.host.id, h.remote_user.username, h.host.hostname))
        bindhost_ids.append(h.host.id)
    print('bind_group(%s):'%len(user.host_groups))
    for g in user.host_groups:
        print('|-group_name:[%s]' % (g.name))
        for h in g.bind_hosts:
            print('|-- [%s],%s@%s ' % (h.host.id,h.remote_user.username,h.host.hostname))
            bindhost_ids.append(h.host.id)
    return bindhost_ids

def start_session(argvs):
    print('going to start sesssion ')
    user = auth()
    if user:
        welcome_msg(user)
        exit_flag = False
        while not exit_flag:
            bindhost_ids = display_access_host(user)
            user_option = input('\033[32;1m%s\033[0m' % ("[%s][(q)quit, select host to login]:")%user.username).strip()
            if len(user_option) == 0: continue
            if user_option == 'q':
                exit_flag = True
                break
            if user_option.isdigit():
                user_option = int(user_option)
                if bindhost_ids.index(user_option)>-1:
                    bindhost = session.query(models.BindHost).filter(models.BindHost.id==user_option).first()
                    if bindhost:
                        ssh_login.ssh_login(user,bindhost,session,log_recording)
                    else:
                        print('input error,find any data...')
                else:
                    print("input error..")
            else:
                print("input error..")


def log_recording(user_obj,bind_host_obj,logs):
    '''
    flush user operations on remote host into DB
    :param user_obj:
    :param bind_host_obj:
    :param logs: list format [logItem1,logItem2,...]
    :return:
    '''
    print("\033[41;1m--logs:\033[0m",logs)

    session.add_all(logs)
    session.commit()

def log_audit():
    pass