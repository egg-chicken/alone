console = require('better-console')

module.exports = class Console
  @print: (obj)->
    str = if obj.to_s? then obj.to_s() else obj
    console.clear()
    console.log(str)
