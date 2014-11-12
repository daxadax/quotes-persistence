module Persistence
  module Gateways
    class QuotesGatewayBackend < Backend

      def initialize
        super
        @table = @database[:quotes]
      end

      private

      def table
        @table
      end

    end
  end
end
