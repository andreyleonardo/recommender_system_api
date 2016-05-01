root = '/home/deploy/apps/recommender_system_api/current'
shared_path = '/home/deploy/apps/recommender_system_api/shared/'
working_directory root

pid "#{shared_path}/tmp/pids/unicorn.pid"

stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

worker_processes 2
timeout 30
preload_app true

listen '/tmp/unicorn.spui.sock', backlog: 64

before_fork do |_server, _worker|
  Signal.trap 'TERM' do
    logger.info  'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |_server, _worker|
  Signal.trap 'TERM' do
    logger.info 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end

# Force the bundler gemfile environment variable to
# reference the capistrano "current" symlink
before_exec do |_|
  ENV['BUNDLE_GEMFILE'] = File.join(root, 'Gemfile')
end
