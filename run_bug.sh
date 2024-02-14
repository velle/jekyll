#bundle exec ruby -w -I"lib:lib:test" /home/velle/a/jekyll/vendor/bundle/ruby/3.0.0/gems/rake-13.1.0/lib/rake/rake_test_loader.rb "test/test_cleaner_foo.rb" "test/test_filters_foo.rb"

bundle exec ruby -w -I"lib:lib:test" \
  /home/velle/a/jekyll/vendor/bundle/ruby/3.0.0/gems/rake-13.1.0/lib/rake/rake_test_loader.rb \
  "test/test_cleaner_foo.rb" "test/test_filters_foo.rb"

#  --seed=40420 \


# TESTOPTS="--seed=1261"

#bundle exec rake test TEST=test/test_filters_foo.rb


bundle exec rake test
