Base              = require('./base')
Dealer            = require('models/dealer')
DungeonView       = require('views/dungeon')
DungeonController = require('controllers/dungeon_controller')

module.exports = class Dungeon extends Base
  constructor: ()->
    @model      = new Dealer()
    @view       = new DungeonView(@model)
    @controller = new DungeonController(@model, @view)
    @controller.onCompleteBoard = =>
      @model.setupBoard()
      @emit('completed')
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
