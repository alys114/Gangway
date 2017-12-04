# Author: Vincent.chan
# Blog: http://blog.alys114.com

import os,sys

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

print(BASE_DIR)
sys.path.append(BASE_DIR)

if __name__ == '__main__':
    from modules.actions import excute_from_command_line
    # excute_from_command_line(sys.argv)
    excute_from_command_line(('','start_session'))