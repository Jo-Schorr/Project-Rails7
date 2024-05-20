FROM ruby:3.0.4

WORKDIR /projeto-rails

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client imagemagick libvips

COPY Gemfile /projeto-rails/Gemfile
COPY Gemfile.lock /projeto-rails/Gemfile.lock

RUN docker compose run web rails assets:precompile  

RUN bundle install


COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"] 

