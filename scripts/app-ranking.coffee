# Description:
#   Show AppStore, GooglePlay Ranking
# command:
#    hubot appstore - show appstore ranking (iphone top sales)
request = require('request')

module.exports = (robot) ->
  robot.respond /appstore/i, (msg) ->
    url = 'https://itunes.apple.com/jp/rss/topgrossingapplications/limit=10/genre=6014/json'
    request.get url, (err, res, body) ->
      JSON.parse(body).feed.entry.forEach (ent, index, array) ->
        msg.send "[#{index + 1}] #{ent.title.label} #{ent.link.attributes.href}"

