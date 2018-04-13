#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
from pathlib import Path


def symlink_to_home(files_directory, backup_directory):
    files_directory = Path(files_directory).absolute()
    for subpath in files_directory.iterdir():
        filepath = files_directory / subpath.name
        homefilepath = Path.home() / ("." + subpath.name)
        # create backup if already exists as real file
        if homefilepath.is_file() and not homefilepath.is_symlink():
            backup_directory.mkdir(exist_ok=True)
            backupfilepath = backup_directory / subpath.name
            if backupfilepath.exists():
                #os.remove(str(backupfilepath))
                backupfilepath.unlink()
            shutil.move(str(homefilepath), str(backupfilepath))
        # create symlink
        if homefilepath.exists() or homefilepath.is_symlink():  # deal with broken links
            #os.remove(homefilepath)
            homefilepath.unlink()
        homefilepath.symlink_to(filepath)


if __name__ == "__main__":
    dirname = Path(__file__).parent
    filedir = dirname / "files"
    backupdir = dirname / "backup"
    symlink_to_home(filedir, backupdir)

