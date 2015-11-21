namespace :db do
  desc "Create database for environment in DB_ENV, with optional DB_USER and DB_PASS"
  task :create do
    unless ENV.member?('DB_ENV')
      raise 'Please provide the environment to create for as `ENV[DB_ENV]`'
    end

    env = ENV['DB_ENV']
    user = ENV['DB_USER'] || 'root'
    pass = ENV['DB_PASS']

    `mysql -u#{user} -p#{pass} -e "create database quotes-#{env}"`
  end

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
