Base              = require('./base')
DungeonModel      = require('models/dungeon')
DungeonView       = require('views/dungeon')
DungeonController = require('controllers/dungeon_controller')

module.exports = class Dungeon extends Base
  constructor: ()->
    @model      = new DungeonModel()
    @view       = new DungeonView(@model.dealer)
    @controller = new DungeonController(@model.dealer, @view)
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
    super
