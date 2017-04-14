# How to set up

1. Git clone
1. In the root directory, run `bundle install`
1. Migrate the database `bundle exec rake db:migrate`
1. Run 'bundle exec rails server'


If you have issues with bcrypt-ext:
1. Go into your Gem folder
1. git clone https://github.com/codahale/bcrypt-ruby.git
1. cd bcrypt-ruby
1. gem build bcrypt.gemspec
1. gem install gem-compiler
1. gem compile bcrypt-3.1.10.gem
1. gem install bcrypt-3.1.10-x64-mingw32.gem --local