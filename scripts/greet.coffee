# Description
#   hubot scripts for greeting
#
# Commands:
#   hubot greet - Reply with greeting

module.exports = (robot) ->  
  robot.respond /greet/i, (msg) ->
    msg.reply 'Hi'
