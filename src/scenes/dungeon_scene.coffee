Dealer            = require('models/dealer')
DungeonView       = require('views/dungeon_view')
DungeonController = require('controllers/dungeon_controller')

module.exports = class DungeonScene
  constructor: (@model=new Dealer())->
    @view       = new DungeonView(@model)
    @controller = new DungeonController(@model, @view)
    @controller.onCompleteBoard = => @onComplete("success")
    @controller.onFailedBoard   = => @onComplete("failed")

  play: ->
    @view.activeAllListener()
    @controller.control()

  destruct: ->
    @view.removeAllListeners()
    @model.setupBoard()

  onComplete: ->
    throw new Error("please override me")
