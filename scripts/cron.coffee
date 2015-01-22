cron = require('cron').CronJob

module.exports = (robot) ->
  new cron '*/1 * * * * 1-5', () =>
    robot.messageRoom "#sandbox", "わほーい"
  , null, true, "Asia/Tokyo"

