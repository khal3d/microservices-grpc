FROM grpc/php

RUN apt update -y &&\
    apt install wget git -y

RUN cd /root \
    && wget https://golang.org/dl/go1.14.6.linux-amd64.tar.gz \
    && tar -xvf go1.14.6.linux-amd64.tar.gz \
    && mv go /usr/local


WORKDIR /root

RUN apt install -y zip
RUN rm -rf go1.14.6.linux-amd64.tar.gz

RUN echo 'export GOROOT=/usr/local/go\n\
export GOPATH=$HOME/go\n\
export GOBIN=$GOPATH/bin\n\
export PATH=$GOPATH/bin:$GOROOT/bin:/root/php-grpc:$PATH\
' >> .bashrc

RUN git clone https://github.com/spiral/php-grpc.git /root/php-grpc\
    && cd php-grpc

RUN mkdir ~/go
RUN mkdir ~/go/bin


ENV PATH /root/go/bin:/usr/local/go/bin:/root/php-grpc:$PATH
RUN ~/php-grpc/build.sh

RUN cd ~\
    && git clone -b v1.30.0 https://github.com/grpc/grpc\
    && cd grpc && git submodule update --init

RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer;

WORKDIR /root/grpc
RUN apt -y install automake libtool
RUN make grpc_php_plugin

EXPOSE 9001
EXPOSE 2112

CMD tail -f /dev/null

WORKDIR /var/www/

CMD tail -f /dev/null
