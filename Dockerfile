FROM ruby:3.0

WORKDIR /usr/src/app
RUN git init

RUN apt-get update && apt-get install -y cmake 
RUN addgroup --gid 121 docker && adduser --disabled-password --gid 121 --uid 1001 runner

COPY Gemfile licensee.gemspec ./
COPY lib/licensee/version.rb ./lib/licensee/version.rb
RUN bundle install

USER runner
COPY bin ./bin
COPY lib ./lib
COPY vendor ./vendor

ENTRYPOINT ["bundle", "exec", "./bin/licensee"]
