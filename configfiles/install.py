#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import shutil
import typing as tp
from pathlib import Path


def symlink_to_home(backup_dir: Path, home_dir: tp.Optional[Path] = None) -> None:
    """Creates symlinks of the configuration files in the
    files directory to the home directory.

    Parameters
    ----------
    backup_dir: str or Path
        path of the directory into which existing configuration files
        should be backed-up.
    home_dir: str or Path
        path of the directory into which the files must be symlinked.

    Note
    ----
    Current configuration files are flake8, pylintrc, vimrc and a "myconfig"
    file which should be sourced in the bashrc or zshrc.
    """
    home_dir = Path.home() if home_dir is None else Path(home_dir)
    files_dir = Path(__file__).absolute().parent / "files"
    backup_dir = Path(backup_dir).absolute()
    for subdir in files_dir.iterdir():
        new_file = files_dir / subdir.name
        if subdir.name != "init.vim":
            home_file = home_dir / ("." + subdir.name)
        else:
            home_file = home_dir / ".config" / "neovim" / subdir.name
            home_file.parent.mkdir(exist_ok=True, parents=True)
        # create backup if already exists as real file
        if home_file.is_file() and not home_file.is_symlink():
            backup_dir.mkdir(exist_ok=True)
            backup_file = backup_dir / subdir.name
            if backup_file.exists():
                backup_file.unlink()
            shutil.move(str(home_file), str(backup_file))
        # create symlink
        if home_file.is_file() or home_file.is_symlink():  # deal with broken links
            home_file.unlink()
        home_file.symlink_to(new_file)


if __name__ == "__main__":
    backup_dir_ = Path(__file__).parent / "backup"
    symlink_to_home(backup_dir_)
