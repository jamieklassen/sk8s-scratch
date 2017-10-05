require_relative '../lib/function'

describe Function do
  it 'maps over the input stream and writes to the output stream' do
    subject = described_class.new(Proc.new(&:upcase))
    subject.input = EventStream.new
    subject.output = EventStream.new
    subject.start
    subject.input.write('hello')
    sleep(0.01)
    expect(subject.output.read).to eq 'HELLO'
  end
end
