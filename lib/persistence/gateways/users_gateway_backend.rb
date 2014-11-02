module Persistence
  module Gateways
    class UsersGatewayBackend < Backend

      def initialize
        super
        @table = @database[:users]
      end

      def insert(user)
        ensure_valid!(user)

        @table.insert(user)
      end

      def update(user)
        ensure_persisted!(user)

        @table.where(:uid => user[:uid]).update(user)
      end

      def get(uid)
        @table.first(:uid => uid)
      end

      def all
        @table.all
      end

      def fetch(nickname)
        @table.first(:nickname => nickname)
      end

      def delete(uid)
        @table.where(:uid => uid).delete
      end

    end
  end
end
