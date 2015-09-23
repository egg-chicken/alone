module.exports = class MainController
  constructor: (@view, @dealer)->
    @view.on('press:exit-button', =>@onPressExitButton())
    @view.on('press:item-use-button', (item)=>@onPressItemUseButton(item))
    @view.on('press:move-button', (button)=>@onPressMoveButton(button))
    @view.on('press:skip-round-button', (button)=>@onPressSkipRoundButton(button))

  onPressExitButton: ->
    @view.exit()
    process.exit()

  onPressMoveButton: (button)->
    @dealer.round(button.name)
    @view.render()

  onPressSkipRoundButton: ->
    @dealer.round()
    @view.render()

  onPressItemUseButton: (item)->
    @dealer.round("useItem", item)
    @view.render()
