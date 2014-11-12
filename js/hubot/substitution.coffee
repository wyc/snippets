# Description:
#   say what you mean to say
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   s/<query>/<replacement>/<flags> - correct yourself
#   user: s/<query>/<replacement>/<flags> - correct someone else
#
# Author:
#   wyc

class Substitution

  constructor: (@robot) ->
    @lastLine = {}
    @pattern = /^(?:([^\s]+)?(?:: ))?s\/([^\/\\]*(?:\\.[^\/\\]*)*)\/([^\/\\]*(?:\\.[^\/\\]*)*)(?:\/(.*))?/
    @verbs = [ "actually meant to say", "meant to say", "really meant to say" ]

  setLastLine: (user, line) ->
    @lastLine[user] = line

  getLastLine: (user) ->
    return if @lastLine[user]? then @lastLine[user] else ''

  verb: ->
     @verbs[Math.floor(Math.random() * @verbs.length)]

module.exports = (robot) ->
  substitution = new Substitution robot
  robot.hear substitution.pattern, (msg) ->
    target = msg.match[1]
    query = msg.match[2].replace /\\\//g, '/'
    replace = msg.match[3].replace /\\\//g, '/'
    flags = msg.match[4]
    
    try
      [prefix, user] = if target? then ["#{msg.message.user.name} thinks ", target] else ["", msg.message.user.name]
      lastLine = substitution.getLastLine(user);
      queryPattern = new RegExp(query, if flags? then flags else '');
      response = lastLine.replace queryPattern, replace
      
      if response != '' && response != lastLine
        substitution.setLastLine(msg.message.user.name, response) unless target?;
        msg.send "#{prefix}#{user} #{substitution.verb()}: #{response}"
    catch error
      msg.send "#{msg.message.user.name}, bad regex; #{error}"

  robot.hear /.*/, (msg) ->
    unless substitution.pattern.test(msg.match[0])
      substitution.setLastLine(msg.message.user.name, msg.match[0])


