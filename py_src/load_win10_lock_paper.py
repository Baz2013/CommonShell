# -*- coding:utf-8 -*-

# 自动获取win10的锁屏壁纸
# C:\Users\XXXX\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets

import sys
import datetime
import os
import time
import shutil

des_dir = 'E:\Learn\Win10_lock_paper'


def _load_his_record(r_des_dir):
    """
    读取历史拷贝记录，防止重复拷贝
    :param r_des_dir:
    :return:
    """
    record_dict = dict()
    if not os.path.exists(r_des_dir):
        os.makedirs(r_des_dir)
    his_file = r_des_dir + '\\' + 'his_record.txt'
    if not os.path.exists(his_file):
        handle = open(his_file, 'w')
        handle.close()
        return record_dict

    with open(his_file, 'r') as h:
        lines = h.readlines()
    for line in lines:
        if line != '\n':
            items = line.split('|')
            record_dict[items[0]] = items[1]

    return record_dict


def _write_his_record(r_des_dir, r_record_dict):
    """
    将历史记录重新写回文件
    :param r_des_dir:
    :param r_record_dict:
    :return:
    """
    his_file = r_des_dir + '\\' + 'his_record.txt'
    handle = open(his_file, 'w')
    for items in r_record_dict.items():
        record = items[0] + '|' + items[1] + '\n'
        # print record
        handle.write(record)

    handle.close()


def _get_src_dir():
    """
    创建存放壁纸的目录
    检查目录是否存在
    源目录：存放壁纸的目录
    :return: 源目录
    """
    user_name = os.environ['USERNAME']
    src_dir = 'C:\Users\{0}\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets'.format(
            user_name)
    if not os.path.exists(src_dir):
        print '目录{0}不存在或者不是win10系统'.format(src_dir)
        sys.exit(1)
    return src_dir


def _time_trans(r_unix_time):
    """
    将Unix时间(如:1446715914)转换为正常的时间格式(20151106_202226)
    @value 为的值为时间戳(整形)
    返回 字符串类型的时间
    """
    format = '%Y%m%d_%H%M%S'
    value = time.localtime(r_unix_time)
    # 经过localtime转换后变成
    # time.struct_time(tm_year=2012,tm_mon=3,tm_mday=28,tm_hour=6,tm_min=53,tm_sec=40,tm_wday=2,tm_yday=88,tm_isdst=0)
    # 最后再经过strftime函数转换为正常日期格式
    dt = time.strftime(format, value)
    return dt


def _shift_pictures(r_des_dir):
    """
    转移图片
    :param r_des_dir:
    :return:
    """
    record_dict = _load_his_record(r_des_dir)
    src = _get_src_dir()
    pic_files = os.listdir(src)
    for p in pic_files:
        stat_rst = os.stat(src + '/' + p)
        file_date = _time_trans(stat_rst.st_ctime)
        file_size = stat_rst.st_size
        # print '{0}---{1}---{2}'.format(p, file_date, file_size)
        new_file_name = '{0}_{1}.jpg'.format(file_date, p[-4:])
        # print new_file_name
        if file_size > 1024 * 100 and not record_dict.get(p):
            # print '------'
            shutil.copyfile(src + '/' + p, r_des_dir + '/' + new_file_name)
            record_dict[p] = new_file_name

        _write_his_record(r_des_dir, record_dict)


if __name__ == '__main__':
    # record_dict = _load_his_record(des_dir)
    # print record_dict
    # record_dict['def130'] = '20170409.jpg'
    # _write_his_record(des_dir, record_dict)
    # print _get_src_dir()
    # print _time_trans(1478084257)
    _shift_pictures(des_dir)
