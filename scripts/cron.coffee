#CronJob = require('cron').CronJob
#
#module.exports = (robot) ->
#  new CronJob '*/1 * * * * *', () =>
#    # これだとSlack#generalにメッセージが流れない
#    # robot.messageRoom "#general", "テスト"
#    #console.log("test")
#
#    # これならおっけー☆
#    robot.send {room: "sandbox@#{process.env.HUBOT_XMPP_HOST}"}, "テスト"
#  , null, true, "Asia/Tokyo"
