require_relative '../lib/http_gateway'
require_relative '../lib/event_stream'

describe HttpGateway do
  before do
    subject.output = EventStream.new
  end

  after do
    subject.stop
  end

  it 'writes requests to the output stream' do
    subject.start
    system('curl -d goodbye localhost:8080 2>/dev/null')
    sleep(0.1)
    expect(subject.output.read).to eq 'goodbye'
  end

  it 'returns what it reads from the input stream' do
    subject.input = EventStream.new
    subject.start
    subject.input.write('hello')
    sleep(0.1)
    expect(`curl localhost:8080 2>/dev/null`).to eq 'hello'
  end
end
