#!/bin/python
import re

def read_file(r_file):
    '''
    @r_file  configure file , example  ./rate.cfg
    '''
    with open(r_file,'r') as handle:
        lines = handle.readlines()
    
    str = ""
    for line in lines:
        str = str + line
    
    pattern = re.compile(r'(<\d{5}>)(.*?)(</\d{5}>)',re.S)
    items = re.findall(pattern,str)
    return items

def get_dir(r_line):
    '''
    @line smsremind_path            = ${BOSS_DATA6_SDFS}/smsremind/it0202/
     return   {'smsremind_path':'${BOSS_DATA6_SDFS}/smsremind/it0202/'}
    '''
    dir = {}
    if len(r_line) < 1:
        return None
    t_str = r_line.split('=')
    if len(t_str) < 2:
        return None
    if r'#' in t_str[0]:
        return None
    path_name = t_str[0].lstrip().rstrip().lstrip('\t').rstrip('\t')
    path = t_str[1].split('#')[0]
    path = path.lstrip().rstrip().lstrip('\t').rstrip('\t')
    if r'/' not in path:
        return None

    dir[path_name] = path
    return dir


def get_channel_dir(r_channel_dirs):
    if len(r_channel_dirs) != 3:
        return None
    channel_no = r_channel_dirs[0][1:6]
    str = r_channel_dirs[1].split('\n')
    dirs = []
    for s in str:
        t_dir = get_dir(s)
        if t_dir:
            dirs.append(t_dir)
    return dirs

if __name__ == '__main__':
    file = r'./rr.cfg'
    items = read_file(file)

    all_dirs = {}
    for item in items:
        print item[0],item[2]
        dirs = get_channel_dir(item)
        if dirs:
            all_dirs[item[0][1:6]] = dirs
    
    #result 
    #all_dirs structurs {'61000':[{'input':'...'},{'output':'...'},...],'61001':[...],...}
    channels = all_dirs.keys()
    for channel in channels:
        print channel
        for d in all_dirs[channel]:
            #print d
            print "%s:<%s>" %(d.values()[0],channel)

