web: bin/start-pgbouncer bundle exec rails server -p $PORT -e $RAILS_ENV
release: bundle exec rails db:migrate
worker1: bin/start-pgbouncer bundle exec sidekiq -q very_high -q high -e production -c $WORKER_PRIMARY_CONCURRENCY
scheduler: bundle exec clockwork config/clock.rb