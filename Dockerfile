FROM ubuntu:18.04
LABEL Cybercrunch2137

ENV PYTHONUNBUFFERED 1
ENV PYTHON_PIP_VERSION 19.1.1

RUN apt-get update


# explicitly set user/group IDs
RUN groupadd -r unprivileged --gid=999 && useradd -m -r -g unprivileged --uid=999 unprivileged

RUN apt-get update \
    && apt-get install -q -y --no-install-recommends gettext git gosu \
    python3.6-dev python3-pip python3-setuptools python3-wheel \
    build-essential libgdal-dev redis-server ffmpeg \
    chromium-browser libxcomposite-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# set python 3 as the default python version
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1 \
    && update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

RUN pip3 install --no-cache-dir --upgrade --ignore-installed pip==$PYTHON_PIP_VERSION
RUN pip3 install --upgrade setuptools

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN mkdir /app
WORKDIR /app
COPY ./app /app

#RUN adduser -D user
#USER user
