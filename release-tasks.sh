echo 'Migrating database...'
bundle exec rails db:migrate
echo 'Restarting app...'
bundle exec rails restart
