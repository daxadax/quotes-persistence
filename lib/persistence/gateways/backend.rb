require 'mysql2'
require 'sequel'

module Persistence
  module Gateways
    class Backend
      include Support::ValidationHelpers

      def initialize
        @database = retrieve_database
      end

      private

      def retrieve_database
        raise no_database_provided unless ENV['DATABASE_URL']

        Sequel.connect(ENV['DATABASE_URL'])
      end

      def no_database_provided
        'Please provide the database url to connect to as `ENV[DATABASE_URL]`'
      end

      def no_database_exists
        sql = 'create database <name> '\
        'DEFAULT CHARACTER SET utf8 '\
        'DEFAULT COLLATE utf8_general_ci;'

        "No database exists.  To create one, adjust and execute the following:"\
        "\n\necho \"#{sql}\" | mysql"
      end
    end
  end
end