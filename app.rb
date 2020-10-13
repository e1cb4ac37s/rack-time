require_relative 'time_parser'

class App
  def call(env)
    @request = Rack::Request.new(env)
    route
  end

  def route
    @request.path == '/time' ? time : response(404, 'Not Found')
  end

  def time
    time_parser = TimeParser.new(@request.params)
    if time_parser.valid?
      response(200, time_parser.body)
    else
      response(400, time_parser.error_message)
    end
  end

  def response(status, body)
    response = Rack::Response.new(
      [body],
      status,
      { 'Content-Type' => 'text/plain' }
    )
    response.finish
  end
end
