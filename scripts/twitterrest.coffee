# Description:
#  Watch Twitter by KeyWord
#
# Commands:
#
# Examples:
#
# Depend
#   twitter
#   underscore

twitter = require("twitter")
_ = require("underscore")
CronJob = require('cron').CronJob

BRAIN_KEY = "twitterrestkey"
ROOM="sandbox@#{process.env.HUBOT_XMPP_HOST}"

auth =
  "consumer_key" : process.env.TWITTER_CONSUMER_KEY,
  "consumer_secret" : process.env.TWITTER_CONSUMER_SECRET,
  "access_token_key" : process.env.TWITTER_ACCESS_TOKEN_KEY,
  "access_token_secret" : process.env.TWITTER_ACCESS_TOKEN_SECRET

twit = new twitter(auth)
query = "艦これ"
module.exports = (robot) ->

  new CronJob '*/30 * * * * *', () =>
    lastid = robot.brain.get(BRAIN_KEY) or 0

    twit.get 'search/tweets',
      q: query
      since_id: lastid
      lang:"ja"
    , (err, tweets, respond) ->
      throw err if err
      _.each tweets.statuses.reverse(), (tweet) ->
        if tweet.id > lastid
          robot.brain.set BRAIN_KEY, tweet.id
        console.log(tweet.text)
        robot.send {room: ROOM}, "https://twitter.com/#{tweet.user.id_str}/status/#{tweet.id_str}" if lastid < tweet.id
  , null, true, "Asia/Tokyo"
