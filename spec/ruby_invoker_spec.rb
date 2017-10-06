describe 'Ruby invoker' do
  it 'maps over the input stream and writes to the output stream' do
    File.write('uppercase.rb', 'def uppercase(input); input.upcase; end')
    expect(`echo "hello" | ruby lib/invoker.rb $PWD/uppercase.rb`).to eq "HELLO\n"
    system('rm uppercase.rb')
  end
end
