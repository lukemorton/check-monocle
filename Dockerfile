FROM ruby:2.4
RUN apt-get update -qq && apt-get upgrade -y

RUN apt-get install -y build-essential libxml2-dev libxslt1-dev \
    libfontconfig1 libfontconfig1-dev && \
  apt-get clean

ENV PHANTOM_JS phantomjs-2.1.1-linux-x86_64

RUN wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2 && \
  tar xvjf $PHANTOM_JS.tar.bz2 && \
  mv $PHANTOM_JS /usr/local/share && \
  ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /bin/phantomjs && \
  rm $PHANTOM_JS.tar.bz2
