module Persistence
  module Gateways
    class QuotesGatewayBackend < Backend

      def initialize
        super
        @table = @database[:quotes]
      end

      def insert(quote)
        ensure_valid!(quote)

        @table.insert(quote)
      end

      def get(uid)
        @table.first(:uid => uid)
      end

      def update(quote)
        ensure_persisted!(quote)

        @table.where(:uid => quote[:uid]).update(quote)
      end

      def all
        @table.all
      end

      def delete(uid)
        @table.where(:uid => uid).delete
      end

    end
  end
end