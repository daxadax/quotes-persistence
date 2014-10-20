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

end
