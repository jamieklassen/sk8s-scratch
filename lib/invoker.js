var readline = require('readline');
var fs = require('fs');
var path = require('path');

var rl = readline.createInterface({
  input: process.stdin,
  output: new require('stream').Writable()
});

var funcFile = process.argv[process.argv.length - 1];
var code = fs.readFileSync(funcFile, 'utf8');
eval(code);
var func = eval(path.basename(funcFile, path.extname(funcFile)));

rl.on('line', (line) => console.log(func(line)));
