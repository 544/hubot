# Description:
#   shinchoku commands.
#
# Commands:
#   進捗（どうですか|ダメです|いいです）
#
# Notes:
#   進捗の具合

progress = [
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/01.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/02.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/03.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/04.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/05.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/06.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/07.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/08.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/09.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/10.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/11.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/12.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/13.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/14.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/15.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/16.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/17.gif"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/18.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/19.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/20.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/21.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/22.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/23.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/24.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/25.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/26.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/27.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/28.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/29.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/30.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/31.png"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/32.jpg"
]

bad = [
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/dame/01.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/dame/02.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/dame/03.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/dame/04.gif"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/dame/05.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/dame/06.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/dame/07.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/dame/08.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/dame/09.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/dame/10.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/dame/11.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/dame/12.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/dame/13.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/dame/14.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/dame/15.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/dame/16.jpg"
]

ok = [
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/ok/01.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/ok/02.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/ok/03.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/ok/04.jpg"
  "https://dl.dropboxusercontent.com/u/96769324/img/hubot/ok/05.jpg"
]


module.exports = (robot) ->

  robot.hear /進捗どうですか/, (msg) ->
    msg.send msg.random progress

  robot.hear /進捗(ダメ|だめ)です/, (msg) ->
    msg.send msg.random bad

  robot.hear /進捗(いい|良い|ok|OK)です/, (msg) ->
    msg.send msg.random ok

