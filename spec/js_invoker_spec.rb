describe 'Javascript invoker' do
  it 'maps over the input stream and writes to the output stream' do
    File.write('lowercase.js',
      'function lowercase (input) { return input.toLowerCase(); }'
    )
    expect(`echo "HELLO" | node lib/invoker.js $PWD/lowercase.js`).to eq "hello\n"
    system('rm lowercase.js')
  end
end
