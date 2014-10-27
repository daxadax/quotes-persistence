require 'minitest/autorun'

$LOAD_PATH.unshift('lib', 'spec')

# require all support files
Dir.glob('./spec/support/*.rb')  { |f| require f }

require 'persistence'

ENV['DATABASE_URL'] = 'mysql2://dax:dax@localhost/quotes_test'

class Minitest::Spec
  include Support::AssertionHelpers
  include Support::FactoryHelpers
  include Persistence

  before do
    clean_database
    run_migrations
  end

  def clean_database
    existing_tables       = database.tables
    tables_to_preserve    = [:schema_info, :schema_migrations]
    tables_to_be_emptied  = existing_tables - tables_to_preserve

    tables_to_be_emptied.each { |table| database << "TRUNCATE #{table}" }
  end

  def run_migrations
    Sequel.extension :migration

    Sequel::Migrator.apply(database, migration_directory)
  end

  def database
    @database ||= Sequel.connect(ENV.fetch("DATABASE_URL"))
  end


end
