function_file = ARGV[0]
function_name = File.basename(function_file, File.extname(function_file))
eval(File.read(function_file))
STDIN.each_line do |line|
  puts method(function_name.to_sym).call(line)
end
