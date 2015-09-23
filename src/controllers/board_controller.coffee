module.exports = class BoardController
  constructor: (@boardView, @dealer)->
    @boardView.on('press:exit-button', =>@onPressExitButton())
    @boardView.on('press:item-button', =>@onPressItemButton())
    @boardView.on('press:item-use-button', (item)=>@onPressItemUseButton(item))
    @boardView.on('press:next-button', (button)=>@onPressNextButton(button))

  show: ->
    @boardView.render()

  onPressExitButton: ->
    @boardView.exit()
    @boardView.removeAllListeners('press:exit-button')
    @boardView.removeAllListeners('press:next-button')
    process.exit()

  onPressNextButton: (button)->
    @dealer.turn(button.name)
    @boardView.render()

  onPressItemButton: ->
    @boardView.changeMode()
    @boardView.render()

  onPressItemUseButton: (item)->
    @dealer.turn("useItem", item)
