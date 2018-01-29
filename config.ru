env = ENV['PASSENGER_APP_ENV']

Bundler.require(:default, env)

Dotenv.load("./config/application.env.#{env}")

%w[lib/support lib/rack_apps lib/middleware].each do |dir_name|
  Dir[File.dirname(__FILE__) + "/#{dir_name}/*.rb"].each { |file| require file }
end

CreatePid.for(file: __FILE__, pid: Process.pid)

$logger = Logger.new("./logs/#{env}.log")

App = Rack::Builder.new do
  use Rack::CommonLogger, $logger
  use Rack::ContentType, 'application/json'

  map '/' do
    run DataEndpoint.new
  end
end

run App
