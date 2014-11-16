require 'rake/testtask'

task :default => :test

Rake::TestTask.new do |t|
  t.libs << "spec"
  t.test_files = FileList['spec/**/*_spec.rb']
  t.verbose = true
end

namespace :db do
  desc "Run migrations (optionally include version number)"
  task :migrate do
    require "sequel"
    Sequel.extension :migration

    unless ENV.member?('DATABASE_URL')
      raise 'Please provide a database as `ENV[DATABASE_URL]`'
    end

    version = ENV['VERSION']
    database_url = ENV['DATABASE_URL']
    db = Sequel.connect(database_url)

    if version
      puts "Migrating to version #{version}"
      Sequel::Migrator.run(db, "./migrations", :target => version.to_i)
    else
      puts "Migrating"
      Sequel::Migrator.run(db, "./migrations")
    end

    puts 'Migration complete'
  end

end
