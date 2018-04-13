FROM ubuntu:16.04 

RUN apt-get update && apt-get install -y \
  build-essential \
  vim-gnome \
  git \
  byobu \
  python3 \
  python3-dev \
  python3-pip

RUN rm -f /usr/bin/pip && ln -s /usr/bin/pip3 /usr/bin/pip && pip install -U pip
RUN ln -s /usr/bin/python3 /usr/bin/python

ADD . /worksetup
WORKDIR /worksetup
RUN pip install -r docker/requirements.txt



