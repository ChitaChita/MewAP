# コピペでOK, app_nameもそのままでOK
# 19.01.20現在最新安定版のイメージを取得
FROM ruby:2.5.3

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /MewAP
WORKDIR /MewAP
COPY Gemfile /MewAP/Gemfile
COPY Gemfile.lock /MewAP/Gemfile.lock
RUN bundle install
COPY . /MewAP

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]