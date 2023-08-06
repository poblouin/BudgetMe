FROM ruby:3.2.2-bullseye

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
