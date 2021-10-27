
FROM python:3.9-slim-buster

# ensure local python is preferred over distribution python
ENV PATH /usr/local/bin:$PATH

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
ENV PYTHONUNBUFFERED 1
ENV DEBIAN_FRONTEND noninteractive

# Set build directory
WORKDIR /tmp

# Copy files necessary for build
COPY requirements.txt requirements.txt

# Perform build and cleanup artifacts
RUN \
  apt-get update && apt-get -yqq install apt-utils software-properties-common \
  && apt-get install -y gcc build-essential libcairo2 python-gobject libpango1.0-0 \
    git openssh-client rsync bash \
  && pip install -r requirements.txt \
  && apt-get --purge -yqq remove gcc build-essential gcc-8 cpp-8 python2 python3.7\
  && apt -yqq autoremove \
  && apt -yqq autoclean \
  && rm -rf /tmp/* /var/lib/apt/* \
  && mkdir /docs


COPY docs /docs/docs/
COPY mkdocs.yml /docs/

# Set working directory
WORKDIR /docs


# Expose MkDocs development server port
EXPOSE 8000

# Start development server by default
ENTRYPOINT [""]
CMD ["mkdocs", "serve", "--dev-addr=0.0.0.0:8000"]
