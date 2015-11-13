#-*- coding:utf-8 -*-

import os

class Tools(object):
    '''
    ������,��װ���õĹ��߷���
    '''
    def get_dirs(self,conf_file):
        '''
        @conf_file �����ļ���
        ����Ŀ¼�б�
        �������ļ��е� input_path            =  ${BOSS_DATA1}/rr/it100/ ��,ִ�����
        �������� ${BOSS_DATA1}ת��Ϊ ����·��/bildata1, ����/bildata1/rr/it100 ���뵽Ŀ¼�б���
        ע��: Ŀ¼�б��е�Ԫ�ؿ������Ѿ����ڵ��ļ�
        '''
        dirs = []
        if conf_file[0] == '~':
            full_path = os.path.expanduser(conf_file)
        elif conf_file[0] == r'$':
            index = conf_file.index('}')
            full_path = os.path.expandvars(conf_file[:index + 1]) + conf_file[index + 1:] 
        else:
            full_path = conf_file
        #print full_path
        if not os.path.exists(full_path):
            print 'file %s not exists!!' % full_path
            return None
        handle = open(full_path,'r')
        lines = handle.readlines()
        handle.close()
        for line in lines:
            #print line
            line = line.strip('\n')
            t_str = line.split('=')
            if len(t_str) > 1:
                t_path = t_str[1].split('#')[0]
                t_path = t_path.lstrip().rstrip()
                if r'$' in t_path:
                    pos = t_path.index('}')
                    t_path = os.path.expandvars(t_path[:pos + 1]) + t_path[pos + 1:]
                    dirs.append(t_path)
                elif r'/' in t_path:
                    dirs.append(t_path)
        return dirs

    def make_dir(self,path):
        '''
        ����Ŀ¼
        @path ΪҪ������Ŀ¼
        '''
        if len(path) < 1:
            return False

        if r'$' == path[0]:
            pos = path.index('}')
            t_env = path[2:pos]
            if not os.getenv(t_env):
                print '�������� %s ������ ' %t_env
                return False
            full_path = os.getenv(t_env) + path[pos + 1:]
        elif r'~' == path[0]:
            full_path = os.path.expanduser(path)
        else:
            full_path = path

        if os.path.exists(full_path):
            return True
        else:
            os.makedirs(full_path)
            #print 'makedirs'

        return True


if __name__ == '__main__':
    ## test 
    tool = Tools()
    tool.get_dirs(r'~/log/rate.log')
    tool.get_dirs(r'${BOSS_DATA1}/rate.log')
    tool.get_dirs(r'/ngbss/billing1/log/rate.log')
    #tool.get_dirs(r'~/log/rate.20151025.log')

    rate_dirs = tool.get_dirs(r'~/etc/rate/rate.cfg')

    print len(rate_dirs)
    #for p in rate_dirs:
    #    print p

    tool.make_dir('~/user/gucb/abc.txt')
    tool.make_dir('${HOME}/user/gucb/abc.txt')
    tool.make_dir('${HOME}/user/gucb/g_test')

