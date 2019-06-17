require 'bundler'
Bundler.require

run Opal::Sprockets::Server.new { |s|
  s.append_path 'app'
  s.append_path 'lib'
  s.main = 'index'
  s.index_path = 'index.erb'
}
