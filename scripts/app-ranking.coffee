# Description:
#   Show AppStore, GooglePlay Ranking
# command:
#    hubot ios - show appstore ranking
request = require('request')

module.exports = (robot) ->
  robot.respond /IOS/i, (msg) ->
    url = 'https://itunes.apple.com/jp/rss/topfreeapplications/limit=10/json'
    request.get url, (err, res, body) ->
      JSON.parse(body).feed.entry.forEach (ent, index, array) ->
        msg.send "[#{index + 1}] #{ent.title.label} #{ent.link.attributes.href}"

