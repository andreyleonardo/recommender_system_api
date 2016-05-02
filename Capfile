# Load DSL and set up stages
rbenv_path = '/home/deploy/.rbenv'
require 'capistrano/setup'
require 'capistrano/deploy'

require 'capistrano/rails'
require 'capistrano/bundler'
# require 'capistrano/rvm'
require 'capistrano/rbenv'
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.2.2'
set :rbenv_prefix, "RBENV_ROOT=#{rbenv_path} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{rbenv_path}/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby rails)
set :rbenv_roles, :all # default value
require 'capistrano/puma'
require 'capistrano/sidekiq'
# require 'capistrano/sidekiq/monit'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
