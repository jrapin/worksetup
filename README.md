# Set up ressources

This repository aims at gathering personal resources for setting up a work station.

## Memo

The [Memo](MEMO.md) provides useful commands and configurations for Ubuntu.

## Configuration files

The configfiles module holds custom configuration files such as vimrc etc. and a tool to 
symlink this files to your home directory. This tool can be called with:
```
python3 -m configfiles.install
```
This script will back up existing files to worksetup/configfiles/backup if need be.

## Docker

The `docker` folder provides an basic example of a running docker image.
The docker image can be build from this directory with:
```
docker-compose build
```
and a bash session can be run in this image with:
```
docker-compose run workimage bash
```
