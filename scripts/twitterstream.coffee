# Description:
#  Watch Twitter streams
#  ( https://github.com/chamerling/hubot-twitterstream-script )
#
# Commands:
#   hubot twitterstream watch <tag>   - Start watching a tag
#   hubot twitterstream unwatch <tag> - Stop  watching a tag
#   hubot twitterstream list          - Get the watched tags list
#   hubot twitterstream clear         - Kill them all!
#
# Examples:
#   hubot twitterstream watch github
#
# Author:
#   Christophe Hamerling
#
# Depend
#   ntwitter
#   underscore

twitter = require("ntwitter")
_ = require("underscore")
auth =
  "consumer_key" : "nyZ32mpQsAc0D47R62ZVyQ",
  "consumer_secret" : "G5VfcRncGAIjKgFSvsfiY1O2g05lhPT1Kns6RprOjgA",
  "access_token_key" : "5531372-OYL0PAKeYXFyCGgBF5T0Rb2tMohhz64RHNDlRBPcnB",
  "access_token_secret" : "FI5tE7q9aNi0Zd34OQ3HrYw26NU0LkWVCM6k0JZCsklZN"

twit = new twitter(auth)
twit.verifyCredentials (err, data) ->
  throw new Error(err)  if err
  return

streams = []
module.exports = (robot) ->
  robot.respond /twitterstream watch (.*)$/i, (msg) ->
    tag = msg.match[1]
    twit.stream "statuses/filter",
      track: tag
    , (stream) ->
      streams.push
        key: tag
        fn: stream

      stream.on "data", (data) ->
        msg.send "@" + data.user.screen_name + " (" + data.user.name + ") - " + data.text + "\n"
        return

      stream.on "destroy", (data) ->
        msg.send "I do not watch " + tag + " anymore..."
        return

      return

    msg.send "I start watching " + tag
    return

  robot.respond /twitterstream unwatch (.*)$/i, (msg) ->
    tag = msg.match[1]
    stream = _.find(streams, (s) ->
      s.key is tag
    )
    if stream?
      stream.fn.destroy()
      streams = _.without(streams, _findWhere(streams, stream))
      msg.send "I stopped watching " + tag
    else
      msg.send "I do not known such tag."
    return

  robot.respond /twitterstream list/i, (msg) ->
    if streams.length > 0
      _.each streams, (s) ->
        msg.send s.key
        return

    else
      msg.send "I have no tags."
    return

  robot.respond /twitterstream clear/i, (msg) ->
    if streams.length > 0
      _.each streams, (s) ->
        s.fn.destroy()
        streams = _.without(streams, _.findWhere(streams, s))
        return

    else
      msg.send "I have no tags."
    return

  return
