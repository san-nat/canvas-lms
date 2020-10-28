FROM gitpod/workspace-postgres

RUN sudo apt-get update 
RUN sudo apt -y install zlib1g-dev libxml2-dev libsqlite3-dev libpq-dev libxmlsec1-dev curl build-essential

# Install Ruby
ENV RUBY_VERSION=2.6
RUN rm /home/gitpod/.rvmrc && touch /home/gitpod/.rvmrc && echo "rvm_gems_path=/home/gitpod/.rvm" > /home/gitpod/.rvmrc
RUN bash -lc "rvm install ruby-$RUBY_VERSION && rvm use ruby-$RUBY_VERSION --default"

# Install Node and Yarn
ENV NODE_VERSION=10.16.0
RUN bash -c ". .nvm/nvm.sh && \
        nvm install ${NODE_VERSION} && \
        nvm alias default ${NODE_VERSION} && \
        npm install -g yarn"
ENV PATH=/home/gitpod/.nvm/versions/node/v${NODE_VERSION}/bin:$PATH

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN sudo apt-get update && sudo apt-get -y install yarn=1.10.1-1

WORKDIR /workspace/canvas-lms
RUN bash -lc "gem install bundler"
# RUN for config in amazon_s3 delayed_jobs domain file_store outgoing_mail security external_migration; do cp -v config/$config.yml.example config/$config.yml; done 
# RUN cp config/dynamic_settings.yml.example config/dynamic_settings.yml
# # RUN bash -lc "bundle exec rails canvas:compile_assets"
# RUN cp config/database.yml.example config/database.yml
# RUN createdb canvas_development
# RUN export CANVAS_LMS_ADMIN_EMAIL=snatarajan@instructure.com && export CANVAS_LMS_ADMIN_PASSWORD=password && export CANVAS_LMS_STATS_COLLECTION=opt_out
# RUN export CANVAS_LMS_ACCOUNT_NAME=inst
# # RUN bash -lc "bundle exec rails db:initial_setup"
# # RUN psql -c 'CREATE USER canvas' -d postgres
# # RUN psql -c 'ALTER USER canvas CREATEDB' -d postgres
# # RUN createdb -U canvas canvas_test
# # RUN psql -c 'GRANT ALL PRIVILEGES ON DATABASE canvas_test TO canvas' -d canvas_test
# # RUN psql -c 'GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO canvas' -d canvas_test
# # RUN psql -c 'GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO canvas' -d canvas_test
# # RUN bash -lc "RAILS_ENV=test bundle exec rails db:test:reset"
