require_relative 'time_parser'

class App
  def call(env)
    @request = Rack::Request.new(env)
    route
  end

  def route
    @request.path == '/time' ? time : not_found
  end

  def time
    time_parser = TimeParser.new(@request.params)
    [time_parser.valid? ? 200 : 400, { 'Content-Type' => 'text/plain' }, [time_parser.body]]
  end

  def not_found
    [404, { 'Content-Type' => 'text/plain' }, ['404 Not Found']]
  end
end
