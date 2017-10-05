require 'rack'
require 'rack/server'

class HttpGateway
  attr_accessor :input, :output
  def start
    @thread = Thread.new do
      Rack::Server.start(:app => lambda do |env|
        body = env['rack.input'].read
        unless body == ''
          @output.write(body)
        end
        result = nil 
        unless @input.nil?
          sleep(0.01) until (result = @input.read)
        end
        [200, {}, ["#{result}"]]
      end)
    end
    sleep(1.5)
  end
  def stop
    @thread.kill
  end
end
