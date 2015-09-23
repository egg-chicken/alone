MainView = require('views/main_view')

module.exports = class MainController
  constructor: (@dealer)->
    @view = new MainView(dealer)
    @view.on('press:exit-button', =>@onPressExitButton())
    @view.on('press:item-use-button', (item)=>@onPressItemUseButton(item))
    @view.on('press:move-button', (button)=>@onPressMoveButton(button))
    @view.on('press:skip-round-button', (button)=>@onPressSkipRoundButton(button))
    @view.render()

  onPressExitButton: ->
    @view.exit()
    process.exit()

  onPressMoveButton: (direction)->
    @dealer.round(direction)
    if @dealer.boardIsCompleted()
      @dealer.setupBoard()
      @view.exit()
      @constructor(@dealer)
    @view.render()

  onPressSkipRoundButton: ->
    @dealer.round()
    @view.render()

  onPressItemUseButton: (item)->
    @dealer.round("useItem", item)
    @view.render()
