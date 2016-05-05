# Dockerfile that @asilversempirical believes is minimal to set up crosscat
# in a virtualenv for development.

FROM        ubuntu
RUN         apt-get update -qq --fix-missing

RUN apt-get install -y python-dev python-pip python-virtualenv git
WORKDIR /crosscat
RUN virtualenv testenv
RUN git clone https://github.com/probcomp/crosscat.git
# source doesn't work in here, which makes sense, hence this line instead of what follows
WORKDIR /crosscat/crosscat
RUN /bin/bash -c "source ../testenv/bin/activate && pip install cython numpy pytest scipy && python setup.py build && python setup.py develop"
# RUN source testenv/bin/activate
# RUN pip install cython numpy pytest scipy
# RUN python setup.py build
# RUN python setup.py develop
CMD ./check.sh
