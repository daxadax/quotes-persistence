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

      def fetch(nickname)

      end

    end
  end
end