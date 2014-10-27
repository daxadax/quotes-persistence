require 'sequel'

class BackendSpec < Minitest::Spec

  before do
    run_migrations
  end

  def run_migrations
    Sequel.extension :migration

    Sequel::Migrator.apply(database, "./migrations/")
  end

  def database
    @database ||= Sequel.connect(ENV.fetch("DATABASE_URL"))
  end

end