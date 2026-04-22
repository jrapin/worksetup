import tempfile
from pathlib import Path
import install


class TempConfigDirectories(tempfile.TemporaryDirectory):

    def __enter__(self):
        root_dir = Path(super().__enter__())
        home_dir = root_dir / "home"
        home_dir.mkdir()
        backup_dir = root_dir / "backup"
        return home_dir, backup_dir


def test_context():
    with TempConfigDirectories() as (home_dir, backup_dir):
        assert home_dir.exists()
    assert not home_dir.exists()


def test_install_with_file():
    with TempConfigDirectories() as (home_dir, backup_dir):
        (home_dir / ".vimrc").touch()  # create a file to be backed up
        install.symlink_to_home(backup_dir, home_dir=home_dir)
        # check new files exist
        names = {x.name for x in home_dir.iterdir()}
        assert not names ^ {'.config', '.flake8', '.myconfig', '.pylintrc', '.vimrc'}
        backed_up = {x.name for x in backup_dir.iterdir()}
        assert not backed_up ^ {'vimrc'}


def test_install_with_symlinks():
    with TempConfigDirectories() as (home_dir, backup_dir):
        install.symlink_to_home(backup_dir, home_dir=home_dir)
        assert not backup_dir.exists()  # initially, empty dir
        install.symlink_to_home(backup_dir, home_dir=home_dir)
        assert not backup_dir.exists()  # symlinks should not be copied


def test_install_with_dead_symlink():
    with TempConfigDirectories() as (home_dir, backup_dir):
        # create a dead symlink
        vimrc = home_dir / ".vimrc"
        vimrc.symlink_to(home_dir / "inexistant_file")
        assert not vimrc.exists() and vimrc.is_symlink()  # dead symlink
        install.symlink_to_home(backup_dir, home_dir=home_dir)

