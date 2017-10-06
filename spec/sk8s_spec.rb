require_relative '../lib/sk8s'

describe Sk8s do
  it "pushes a simple Ruby function wired to an HTTP gateway" do
    File.write('uppercase.rb', 'def uppercase(input); input.upcase; end')
    subject.push('http <|> uppercase')
    expect(`curl -d hello localhost:8080 2>/dev/null`).to eq 'HELLO'
    system('rm uppercase.rb')
  end

  it "pushes a simple Javascript function wired to an HTTP gateway" do
    File.write('uppercase.js', 'uppercase = (input) => input.toUpperCase();')
    subject.push('http <|> uppercase')
    expect(`curl -d hello localhost:8080 2>/dev/null`).to eq 'HELLO'
    system('rm uppercase.js')
  end
end
