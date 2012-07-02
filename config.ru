require './app'

use Rack::ShowExceptions
run SmartTester::Server.new
