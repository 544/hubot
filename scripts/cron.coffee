CronJob = require('cron').CronJob

module.exports = (robot) ->
  new CronJob '*/1 * * * * *', () =>
    # これだとSlack#generalにメッセージが流れない
    # robot.messageRoom "#general", "テスト"
    console.log("test")

    # これならおっけー☆
    robot.messageRoom "sandbox", "テスト"
  , null, true, "Asia/Tokyo"
