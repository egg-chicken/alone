Dealer            = require('models/dealer')
DungeonView       = require('views/dungeon_view')
DungeonController = require('controllers/dungeon_controller')

module.exports = class DungeonScene
  constructor: (@model=new Dealer())->
    @view       = new DungeonView(@model)
    @controller = new DungeonController(@model, @view)
    @controller.onCompleteBoard = =>
      console.log("completed!")
      @destruct()
      process.exit()

  play: ->
    @view.activeAllListener()
    @controller.control()

  destruct: ->
    @view.removeAllListeners()
    @model.setupBoard()
