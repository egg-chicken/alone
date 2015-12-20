Base         = require('./base')
CompleteView = require('views/complete')
module.exports = class CompleteScene extends Base
  constructor: ->
    @view = new CompleteView()

  play: ->
    @view.render()
    @emit('completed')
