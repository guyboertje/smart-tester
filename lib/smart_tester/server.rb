require 'thin'
require 'sinatra/base'
require 'haml'
require 'json'
require 'uri'
require 'yaml'

require 'sinatra/environment'
require 'sinatra/logging'
require 'sinatra/subdomains'

Counter = []

module SmartTester
  class Server < Sinatra::Base

    register Sinatra::Environment
    register Sinatra::Logging
    register Sinatra::Subdomain

    configure :production, :development do
      enable :logging
    end

    configure :test, :development do
    end

    set :root, File.dirname(File.expand_path(__FILE__)) + '/../..'
    enable :raise_errors
    enable :dump_errors

    before do
      if request.request_method == 'OPTIONS'
        response.headers["Access-Control-Allow-Origin"] = "*"
        response.headers["Access-Control-Allow-Methods"] = "GET"
        response.headers["Access-Control-Allow-Headers"] = "Content-Type, X-Smartupdater"


        halt 200
      end
    end

    get "/" do
      headers "Access-Control-Allow-Origin" => "*"
      Counter.clear
      ""
    end

    get "/check_progress" do

      headers "Access-Control-Allow-Origin" => "*"

      Counter << 1
      
      if Counter.length == 3
        status 200
        emit_json( information: "ok" )
      else
        status 404
        emit_json( {} )
      end

    end

    # start the server if ruby file executed directly
    # run! if app_file == $0

    def emit_json(obj)
      content_type :json
      obj.to_json
    end
  end
end
