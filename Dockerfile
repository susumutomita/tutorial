FROM ruby:3.1.2

RUN apt-get update -qq \
  && apt-get install -y nodejs postgresql-client npm imagemagick \
  && rm -rf /var/lib/apt/lists/* \
  && npm install --global yarn

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

RUN mkdir -p /myapp/tmp && chmod -R 777 /myapp/tmp

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
