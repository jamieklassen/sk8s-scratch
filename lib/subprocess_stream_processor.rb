require 'open3'

class SubprocessStreamProcessor
  attr_accessor :input, :output
  def initialize(command)
    @command = command
  end
  def start
    @stdin, @stdout, @sp_thread = Open3.popen2(@command)
    @io_thread = Thread.new do
      loop do
        event = @input.read
        if event
          @stdin.puts event
          @output.write(@stdout.gets.strip)
        end
      end
    end
  end
  def stop
    @io_thread.kill
    @sp_thread.kill
  end
end
