Base              = require('./base')
DungeonModel      = require('models/dungeon')
DungeonView       = require('views/dungeon')
DungeonController = require('controllers/dungeon_controller')

module.exports = class Dungeon extends Base
  constructor: ()->
    @model = new DungeonModel()
    @model.setup()
    @view = new DungeonView(@model)
    @controller = new DungeonController(@model, @view)
    @controller.onCompleteBoard = => @emit('completed')
    @controller.onFailedBoard   = => @emit('failed')

  play: ->
    @controller.control()
    @view.activeAllListener()
    @view.render()

  destruct: ->
    @view.removeAllListeners()
    super
