CronJob = require('cron').CronJob

module.exports = (robot) ->
  new CronJob '0 * * * * *', () =>
    # これだとSlack#generalにメッセージが流れない
    # robot.messageRoom "#general", "テスト"

    # これならおっけー☆
    robot.messageRoom "general", "テスト"
  , null, true, "Asia/Tokyo"
