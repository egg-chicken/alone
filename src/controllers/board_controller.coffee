module.exports = class BoardController
  constructor: (@boardView, @dealer)->
    @boardView.on('press:exit-button', =>@onPressExitButton())
    @boardView.on('press:next-button', =>@onPressNextButton())

  show: ->
    @boardView.render()

  onPressExitButton: ->
    @boardView.exit()
    @boardView.removeAllListeners('press:exit-button')
    @boardView.removeAllListeners('press:next-button')
    process.exit()

  onPressNextButton: ->
    @dealer.turn()
    @boardView.render()
