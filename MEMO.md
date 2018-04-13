# Memo

This memo provides useful commandlines and configurations for Ubuntu.


## Essential packages

The following provides standard application such as:
 - vim: for editing text files
 - git: for versioning
 - screen/byobu: for terminal multiplexer
 - vlc: for playing movies
 - python3: for programming

```
sudo apt-get update && sudo apt-get install -y \
  build-essential \
  vim-gnome \
  git \
  screen \
  byobu \
  vlc \
  python3 \
  python3-dev \
  python3-pip \
```

## Byobu

A Byobu session can be created with:
```
byobu-tmux new-session -s <name>
```
Kill with Ctlr+F6, or detach with F6 and reattach with:
```
tmux attach -t <name>
```

`myconfig` file in the configfiles module proves a shortcut for creating or attaching a session if it exists (and splitting it with vim on the left and ipython on the right for use with vim-slime).


## Git

### Configuration

You can configure your git account with:
```
git config --global user.name "Your name"
git config --global user.email your@email.com
```

Changing the default editor to vim can be done with:
```
git config --global core.editor vim
```

### Git-up

Git-up aims at updating distant branches easily. It can be installed through:
```
sudo apt-get install -y ruby-dev
sudo gem install git-up
```


## Python virtualenv

Virtualenv allows to have several Python package environments on a computer. Virtualenv, and a convenient wrapper called virtualenvwrapper, can be installed with:
```
sudo pip install virtualenv virtualenvwrapper
```

Then configure the folder where the environments will be stored by adding these lines in your bashrc/zshrc:
```
export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
```

Virtualenvs are easily created with an instruction as follows (for a Python3 environment):
```
mkvirtualenv --python=/usr/bin/python3 <name>
```


## ZSH

ZSH is an alternative shell with a very efficient configuration framework called `Oh My Zsh`. Installation instruction for Zsh are found [here](https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH), and for `Oh My Zsh` [here](https://github.com/robbyrussell/oh-my-zsh/blob/master/README.md).

You can easily add plugins through the `plugins=` line of your `.zshrc`. Popular plugins are `sudo` or `autojump` for instance.


## Latex

In order to install latex, with texmaker as an editor and jabref to deal with the references, you can run (beware: slow):
```
sudo apt-get install -y \
  texlive-full \
  texmaker \
  jabref 
```

FYI, language dictionaries can be downloaded through the language support in system parameters.
