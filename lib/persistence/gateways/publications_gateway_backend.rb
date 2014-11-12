module Persistence
  module Gateways
    class PublicationsGatewayBackend < Backend

      def initialize
        super
        @table = @database[:publications]
      end

      private

      def table
        @table
      end

    end
  end
end
