FROM ruby:2.2

# This prevents us from get errors during apt-get installs as it notifies the environment that it is a non-interactive one.
ENV DEBIAN_FRONTEND noninteractive

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN apt-add-repository ppa:anton+/photo-video-apps 
RUN apt-get update -y 
RUN apt-get install -y imagemagick libmagickwand-dev nodejs mysql-client postgresql-client sqlite3 --no-install-recommends
RUN apt-get install --reinstall ghostscript
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install

COPY . /usr/src/app

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]





