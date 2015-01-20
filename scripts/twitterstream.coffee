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
  "consumer_key" : "i9m7pldIaKCVCW0eJxcQGZ7Z9",
  "consumer_secret" : "OuByfBaIM4ki6eqYXU5dZurxictsQnxkqIBrZmrMYuzhN16uR1",
  "access_token_key" : "2990863585-yxChm9ukKOd2F3SLHHw2kdihHvMsDyuEZpZ5mho",
  "access_token_secret" : "eOufpDxjNvG8EaB5OAM3UJhDjs65SSP81ALmUItQs42i6"

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
