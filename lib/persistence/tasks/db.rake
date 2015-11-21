namespace :db do
  desc "Create database for environment in DB_ENV, with optional DB_USER and DB_PASS"
  task :create do
    unless ENV.member?('DB_ENV')
      raise 'Please provide the environment to create for as `ENV[DB_ENV]`'
    end

    env = ENV['DB_ENV']
    user = ENV['DB_USER'] || 'root'
    pass = ENV['DB_PASS']

    `mysql -u#{user} -p#{pass} -e "create database quotes_#{env}"`
  end

  desc "Run migrations (optionally include version number)"
  task :migrate do
    require "sequel"
    Sequel.extension :migration

    unless ENV.member?('DB_URL')
      raise 'Please provide a database as `ENV[DB_URL]`'
    end

    version = ENV['VERSION']
    database_url = ENV['DB_URL']
    migration_dir = File.expand_path('../../../../migrations', __FILE__)
    db = Sequel.connect(database_url)

    if version
      puts "Migrating to version #{version}"
      Sequel::Migrator.run(db, migration_dir, :target => version.to_i)
    else
      puts "Migrating"
      Sequel::Migrator.run(db, migration_dir)
    end

    puts 'Migration complete'
  end
end
