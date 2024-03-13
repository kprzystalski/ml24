FROM ubuntu:18.04

ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone 

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8 

RUN apt update && apt install -y \
  python3-pip \
  unzip \
  wget \
  vim \
  git \
  graphviz

RUN pip3 install --upgrade pip
RUN pip3 install --upgrade setuptools

RUN pip3 install \
  seaborn \
  jupyterlab \
  jupyter-core \
  notebook

#RUN pip3 install --use-deprecated=legacy-resolver \
#  xai
#  aix360

RUN pip3 install \
#  lime \
  opencv-python \
  pydot \
  scipy \
  numpy \
  requests \
  matplotlib

RUN pip3 install \
  pandas \
  pandas-profiling==2.8.0 \
  sklearn

RUN pip3 install \
#  spacy \
#  rasa \
#  nltk \
#  textblob \
  tensorflow \
  keras \
  scipy
#  flask

#RUN pip3 install rasa-x -i https://pypi.rasa.com/simple

EXPOSE 8888
EXPOSE 9000
EXPOSE 5000
EXPOSE 5050
EXPOSE 6006

#RUN python3 -m spacy download en
RUN useradd -ms /bin/bash kprzystalski
RUN adduser kprzystalski sudo


USER kprzystalski
WORKDIR /home/kprzystalski/
RUN mkdir /home/kprzystalski/workshop/

VOLUME ["/home/kprzystalski/workshop/"]  
CMD jupyter lab --ip=0.0.0.0 --allow-root --NotebookApp.token='' --NotebookApp.password='' --no-browser --notebook-dir=/home/kprzystalski/workshop/
