# Description:
#  Watch Twitter streams
#
# Commands:
#   hubot twitter watch <tag>   - Start watching a tag
#   hubot twitter unwatch <tag> - Stop  watching a tag
#   hubot twitter list          - Get the watched tags list
#   hubot twitter clear         - Kill them all!
#
# Examples:
#   hubot twitter watch github
#
# Depend
#   ntwitter
#   underscore

twitter = require("twitter")
_ = require("underscore")
auth =
  "consumer_key" : process.env.TWITTER_CONSUMER_KEY,
  "consumer_secret" : process.env.TWITTER_CONSUMER_SECRET,
  "access_token_key" : process.env.TWITTER_ACCESS_TOKEN_KEY,
  "access_token_secret" : process.env.TWITTER_ACCESS_TOKEN_SECRET

twit = new twitter(auth)

tracks = [ "グラコレ", "グランドコレクション", "艦これ" ]
streams = []
module.exports = (robot) ->

  # init
  #_.each tracks, (track) ->
  #  createTwitterStream("sandbox", track)

  # respond 
  robot.respond /twitter watch (.*)$/i, (msg) ->
    twit.stream 'statuses/filter',
      track: msg.match[1]
    , (stream) ->
      streams.push {key: msg.match[1], fn: stream}
      stream.on "data", (data) ->
        robot.messageRoom msg.room, "@" + data.user.screen_name + " (" + data.user.name + ") - " + data.text + "\n"
      stream.on "destroy", (data) ->
        robot.messageRoom msg.room, "I do not watch " + msg.match[1] + " anymore..."
    msg.send "I start watching " + msg.match[1]

  robot.respond /twitter unwatch (.*)$/i, (msg) ->
    tag = msg.match[1]
    stream = _.find(streams, (s) ->
      s.key is tag
    )
    if stream?
      stream.fn.destroy()
      streams = _.without(streams, _.findWhere(streams, stream))
    msg.send "I stopped watching " + tag

  robot.respond /twitter list/i, (msg) ->
    if streams.length > 0
      _.each streams, (s) ->
        msg.send s.key
    else
      msg.send "I have no tags."

  robot.respond /twitter clear/i, (msg) ->
    if streams.length > 0
      _.each streams, (s) ->
        s.fn.destroy()
        streams = _.without(streams, _.findWhere(streams, s))
    else
      msg.send "I have no tags."
