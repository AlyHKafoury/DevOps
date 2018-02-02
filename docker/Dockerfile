FROM ruby:2.3.3-slim
MAINTAINER Aly Kafoury <aly.kafoury@gmail.com>

RUN apt-get update && apt-get install -qq -y build-essential nodejs libpq-dev postgresql-client-9.4 --fix-missing --no-install-recommends

ENV WORKER_PROCESSES=1
ENV LISTEN_ON=0.0.0.0:8000
ENV CACHE_URL=redis://redis:6379/0
ENV JOB_WORKER_URL=redis://redis:6379/0
ENV INSTALL_PATH /drkiq

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY ./app/drkiq/Gemfile Gemfile
RUN bundle install

COPY ./app/drkiq .

RUN bundle exec rake RAILS_ENV=production DATABASE_URL=postgresql://user:pass@127.0.0.1/dbname SECRET_TOKEN=pickasecuretoken assets:precompile

VOLUME ["$INSTALL_PATH/public"]

CMD bundle exec rails db:migrate
CMD bundle exec unicorn -c config/unicorn.rb
