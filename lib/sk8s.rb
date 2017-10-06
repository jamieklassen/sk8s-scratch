require_relative 'http_gateway'
require_relative 'event_stream'
require_relative 'subprocess_stream_processor'

class Sk8s
  def push(pipeline)
    producer = HttpGateway.new 
    function_name = pipeline.split.last
    function_file = Dir["*#{function_name}*"].first
    if function_file.end_with?('.rb')
      consumer = SubprocessStreamProcessor.new "ruby lib/invoker.rb #{function_file}"
    elsif function_file.end_with?('.js')
      consumer = SubprocessStreamProcessor.new "node lib/invoker.js #{function_file}"
    end
    p_to_c = EventStream.new
    c_to_p = EventStream.new
    producer.output = consumer.input = p_to_c
    consumer.output = producer.input = c_to_p
    producer.start
    consumer.start
  end
end
