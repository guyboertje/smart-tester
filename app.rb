$LOAD_PATH.unshift 'lib'
require 'smart_tester'

# start the server if ruby file executed directly
SmartTester::Server.run! if __FILE__ == $0

