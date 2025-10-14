# vim: set filetype=ruby et sw=2 ts=2:

require 'gem_hadar'

GemHadar do
  name        'acts_as_account'
  author      [ "Thies C. Arntzen, Norman Timmler, Matthias Frick, Phillip Oertel" ]
  email       'developers@betterplace.org'
  homepage    "http://github.com/betterplace/acts_as_account"
  summary     'acts_as_account implements double entry accounting for Rails models'
  description 'acts_as_account implements double entry accounting for Rails models. Your models get accounts and you can do consistent transactions between them. Since the documentation is sparse, see the spec files for usage examples.'
  test_dir    'tests'
  ignore      '.*.sw[pon]', 'pkg', 'Gemfile.lock', 'coverage', '.rvmrc',
    '.AppleDouble', 'tags', '.byebug_history', '.DS_Store'
  readme      'README.rdoc'
  title       "#{name.camelize} -- More Math in Ruby"
  licenses << 'Apache-2.0'

  dependency 'activerecord',         '>= 4.1', '<7'
  dependency 'actionpack'  ,         '>= 4.1', '<7'
  dependency 'database_cleaner',     '~> 1.3'
  development_dependency 'mysql2'
  development_dependency 'rspec',    '~> 3.1'
  development_dependency 'simplecov'
  development_dependency 'complex_config'
end

def connect_database
  require 'logger'
  require 'active_record'
  require 'complex_config'
  config = ComplexConfig::Provider.config 'spec/db/database.yml'
  connection_config = config.acts_as_account.to_h
  connection_config.delete(:database)
  ActiveRecord::Base.establish_connection(connection_config).connection
end

namespace :spec do
  desc "create test database out of db/schema.rb"
  task :create_database do
    conn = connect_database
    conn.execute('DROP DATABASE IF EXISTS acts_as_account')
    conn.execute('CREATE DATABASE acts_as_account')
    conn.execute('USE acts_as_account')
    load(File.dirname(__FILE__) + '/spec/db/schema.rb')
  end
end

desc "Run specs"
task :spec => :'spec:create_database' do
  ruby '-S', 'rspec', 'spec'
end

task :test => :spec
