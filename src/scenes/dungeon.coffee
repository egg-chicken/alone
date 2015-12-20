Base              = require('./base')
DungeonView       = require('views/dungeon_view')
DungeonController = require('controllers/dungeon_controller')

module.exports = class Dungeon extends Base
  constructor: (@model)->
    @view       = new DungeonView(@model)
    @controller = new DungeonController(@model, @view)
    @controller.onCompleteBoard = => @emit('completed')
    @controller.onFailedBoard   = => @emit('failed')

  play: ->
    @controller.control()
    @view.activeAllListener()
    @view.render()

  destruct: ->
    @view.removeAllListeners()
    @view       = null
    @controller = null
    @model      = null
    super
