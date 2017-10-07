require 'webrick'

class HttpGateway
  attr_accessor :input, :output
  def start
    @thread = Thread.new do
      server = WEBrick::HTTPServer.new({
        :Port => 8080,
        :Logger => WEBrick::Log::new("/dev/null"),
        :AccessLog => []
      })
      server.mount_proc('/', method(:service))
      server.start
    end
    sleep(0.01)
  end
  def service(req, resp)
    body = req.body
    unless body == ''
      @output.write(body)
    end
    result = nil
    unless @input.nil?
      sleep(0.01) until (result = @input.read)
    end
    resp.status = 200
    resp.content_type = 'text/plain'
    resp.body = "#{result}"
  end
  def stop
    @thread.kill
  end
end
