EventEmitter = require('events').EventEmitter

# emit('completed') で終了イベントを送る。
module.exports = class Base extends EventEmitter
  play:     ->
    @emit('completed')
  destruct: ->
    @removeAllListeners()
