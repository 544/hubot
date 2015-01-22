cron = require('cron').CronJob

module.exports = (robot) ->
  new cron '* * * * * 1-5', () =>
    robot.send {room: "#sandbox"}, "わほーい"
  , null, true, "Asia/Tokyo"

