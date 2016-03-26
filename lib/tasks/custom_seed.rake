namespace :db do
  desc 'Seeders'
  namespace :tasks do
    Dir[File.join(Rails.root, 'db', 'tasks', '*.rb')].each do |filename|
      task_name = File.basename(filename, '.rb').intern
      task task_name => :environment do
        load(filename) if File.exist?(filename)
      end
    end
  end
end
