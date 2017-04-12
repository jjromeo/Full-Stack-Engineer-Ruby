%w(
  .ruby-version
  .rbenv-vars
  tmp/restart.txt
  tmp/caching-dev.txt
  secrets.yml
).each { |path| Spring.watch(path) }
