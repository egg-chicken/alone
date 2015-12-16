module.exports = class GameOverScene
  constructor: ->
    @view = new GameOverView()

  play: ->
    @view.render()
    @onFinished()

  destruct: ->
    @view = null

  onFinished: ->
    throw new Error("please override me")
