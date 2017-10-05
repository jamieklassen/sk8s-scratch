require 'fakefs'
require_relative '../lib/sk8s'

describe Sk8s do
  it "pushes a simple Ruby function wired to an HTTP gateway" do
    FakeFS do
      File.write('uppercase.rb', 'def uppercase(input); input.upcase; end')
      subject.push('http <|> uppercase')
      expect(`curl -d hello localhost:8080 2>/dev/null`).to eq 'HELLO'
    end
  end
end
