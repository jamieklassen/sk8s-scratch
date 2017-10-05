class Sk8s
  def push(pipeline)
    producer = HttpGateway.new 
    function_name = pipeline.split.last
    eval(File.read(Dir["*#{function_name}*"].first))
    consumer = Function.new(method(function_name.to_sym))
    p_to_c = EventStream.new
    c_to_p = EventStream.new
    producer.output = consumer.input = p_to_c
    consumer.output = producer.input = c_to_p
    producer.start
    consumer.start
  end
end
