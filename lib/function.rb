class Function
  attr_accessor :input, :output
  def initialize(method)
    @method = method
  end
  def start
    Thread.new do
      loop do
        event = @input.read
        if event
          response = @method.call(event)
          @output.write(response)
        end
      end
    end
  end
end
