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
    parsed = TimeParser.call(@request.params)
    if parsed.valid?
      response(200, parsed.body)
    else
      response(400, parsed.error_message)
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
