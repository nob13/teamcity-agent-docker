FROM sjoerdmulder/java8

RUN wget -O /usr/local/bin/docker https://get.docker.com/builds/Linux/x86_64/docker-1.9.4
RUN chmod +x /usr/local/bin/docker
ADD 10_wrapdocker.sh /etc/my_init.d/10_wrapdocker.sh
RUN groupadd docker

RUN apt-get update
RUN apt-get install -y unzip iptables lxc build-essential fontconfig

ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8
ENV AGENT_DIR  /opt/buildAgent

# Check install and environment
ADD 00_checkinstall.sh /etc/my_init.d/00_checkinstall.sh

RUN adduser --disabled-password --gecos "" teamcity
RUN sed -i -e "s/%sudo.*$/%sudo ALL=(ALL:ALL) NOPASSWD:ALL/" /etc/sudoers
RUN usermod -a -G docker,sudo teamcity
RUN mkdir -p /data

EXPOSE 9090

VOLUME /var/lib/docker
VOLUME /data
VOLUME /opt/buildAgent

# Install ruby and node.js build repositories
RUN apt-add-repository ppa:chris-lea/node.js
RUN apt-add-repository ppa:brightbox/ruby-ng
RUN apt-get update

# Install node.js environment
RUN apt-get install -y nodejs git
RUN npm install -g bower grunt-cli

# Install ruby environment
RUN apt-get install -y ruby2.1 ruby2.1-dev ruby ruby-switch build-essential
RUN ruby-switch --set ruby2.1
RUN gem install rake bundler compass --no-ri --no-rdoc

# Install MongoDB Server (it will not run, but executable will be there)
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
RUN apt-get update
RUN apt-get install -y mongodb-org


# Add Reactive Core CA
RUN curl https://www.reactivecore.de/files/reactivecore.ca.crt > /usr/local/share/ca-certificates/reactivecore.ca.crt && update-ca-certificates

# Install PhantomJS (See: https://gist.github.com/julionc/7476620) 
RUN apt-get install -y build-essential chrpath libssl-dev libxft-dev libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev
ENV PHANTOM_JS="phantomjs-1.9.7-linux-x86_64"
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2
RUN mv $PHANTOM_JS.tar.bz2 /usr/local/share/; cd /usr/local/share/; tar xvjf $PHANTOM_JS.tar.bz2
RUN ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin/phantomjs
RUN ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/bin/phantomjs



ADD service /etc/service
