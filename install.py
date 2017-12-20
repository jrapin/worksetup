#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import shutil


def symlink_to_home(files_directory, backup_directory):
    files_directory = os.path.abspath(files_directory)
    for basename in os.listdir(files_directory):
        filepath = os.path.join(files_directory, basename)
        homefilepath = os.path.expanduser(os.path.join("~", "." + basename))
        # create backup if already exists as real file
        if os.path.isfile(homefilepath) and not os.path.islink(homefilepath):
            if not os.path.exists(backup_directory):
                os.mkdir(backup_directory)
            backupfilepath = os.path.join(backup_directory, basename)
            shutil.move(homefilepath, backupfilepath)
        # create symlink
        if os.path.exists(homefilepath):
            os.remove(homefilepath)
        os.symlink(filepath, homefilepath)


if __name__ == "__main__":
    dirname = os.path.dirname(__file__)
    filedir = os.path.join(dirname, "files")
    backupdir = os.path.join(dirname, "backup")
    symlink_to_home(filedir, backupdir)

