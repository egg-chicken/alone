DungeonView       = require('views/dungeon_view')
DungeonController = require('controllers/dungeon_controller')

module.exports = class DungeonScene
  constructor: (@model)->
    @view       = new DungeonView(@model)
    @controller = new DungeonController(@model, @view)
    @controller.onCompleteBoard = => @onFinished("success")
    @controller.onFailedBoard   = => @onFinished("failed")

  play: ->
    @controller.control()
    @view.activeAllListener()
    @view.render()

  destruct: ->
    @view.removeAllListeners()
    @view       = null
    @controller = null
    @model      = null

  onFinished: ->
    throw new Error("please override me")
