log = console.log

cp = require 'child_process'

task 'test', 'Scriptテスト', ->
  cp.spawn "mocha"
    ,[ "--compilers", "coffee:coffee-script/register"]
    ,{ stdio: 'inherit' }
