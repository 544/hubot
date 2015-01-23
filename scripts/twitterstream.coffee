# Description:
#  Watch Twitter streams
#  ( https://github.com/chamerling/hubot-twitterstream-script )
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

twitter = require("ntwitter")
_ = require("underscore")
auth =
  "consumer_key" : process.env.TWITTER_CONSUMER_KEY,
  "consumer_secret" : process.env.TWITTER_CONSUMER_SECRET,
  "access_token_key" : process.env.TWITTER_ACCESS_TOKEN_KEY,
  "access_token_secret" : process.env.TWITTER_ACCESS_TOKEN_SECRET

twit = new twitter(auth)
twit.verifyCredentials (err, data) ->
  throw new Error(err,data)  if err

tracks = [ "グラコレ", "グランドコレクション" ]

streams = []
module.exports = (robot) ->
  createTwitterStream = (room, tag) =>
    twit.stream "statuses/filter",
      track: tag
    , (stream) ->
      streams.push
        key: tag
        fn: stream
      stream.on "data", (data) ->
        robot.messageRoom room, "@" + data.user.screen_name + " (" + data.user.name + ") - " + data.text + "\n"
      stream.on "destroy", (data) ->
        robot.messageRoom room, "I do not watch " + tag + " anymore..."

  destroyTwitterStream = (tag) =>
    stream = _.find(streams, (s) ->
      s.key is tag
    )
    if stream?
      stream.fn.destroy()
      streams = _.without(streams, _.findWhere(streams, stream))

  # init
  _.each tracks, (track) ->
    createTwitterStream("#sandbox", track)

  # respond 
  robot.respond /twitter watch (.*)$/i, (msg) ->
    createTwitterStream(msg.room, msg.match[1])
    msg.send "I start watching " + msg.match[1]

  robot.respond /twitter unwatch (.*)$/i, (msg) ->
    tag = msg.match[1]
    destroyTwitterStream(tag)
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

