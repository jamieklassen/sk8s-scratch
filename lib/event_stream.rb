class EventStream
  def initialize
    @queue = []
  end
  def write(event)
    @queue.push(event)
  end
  def read
    @queue.shift
  end
end
