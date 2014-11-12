require 'mysql2'
require 'sequel'

module Persistence
  module Gateways
    class Backend
      include Support::ValidationHelpers

      def initialize
        @database = retrieve_database
      end

      def insert(object)
        ensure_valid!(object)

        table.insert(object)
      end

      def get(uid)
        table.first(:uid => uid)
      end

      def update(object)
        ensure_persisted!(object)

        table.where(:uid => object[:uid]).update(object)
      end

      def all
        table.all
      end

      def delete(uid)
        table.where(:uid => uid).delete
      end

      private

      def ensure_valid!(obj)
        ensure_hash!(obj)
        ensure_not_persisted!(obj)
      end

      def ensure_not_persisted!(obj)
        reason = "Objects can't be added twice. Use #update instead"

        raise_argument_error(reason, obj) unless obj[:uid].nil?
      end

      def ensure_persisted!(obj)
        reason = "Objects must exist to update them. Use #insert instead"

        raise_argument_error(reason, obj) if obj[:uid].nil?
      end

      def ensure_hash!(obj)
        reason = "Only Hashes can be inserted"

        unless obj.kind_of? Hash
          raise_argument_error(reason, obj)
        end
      end

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
