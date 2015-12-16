MainView = require('views/main_view')
Command  = require('models/command/')

module.exports = class DungeonSceneController
  constructor: (@dealer)->
    @view = new MainView(@dealer)
    @view.on('press:exit-button', =>@onPressExitButton())
    @view.on('press:item-use-button', (item)=>@onPressItemUseButton(item))
    @view.on('press:move-button', (button)=>@onPressMoveButton(button))
    @view.on('press:skill-button', (button)=>@onPressSkillButton(button))
    @view.on('press:skip-round-button', (button)=>@onPressSkipRoundButton(button))
    @view.render()

  onPressExitButton: ->
    @view.exit()
    process.exit()

  onPressMoveButton: (direction)->
    command = new Command.MoveOrAttack(@_hero(), direction)
    @dealer.round(command)
    if @dealer.boardIsCompleted()
      @dealer.setupBoard()
      @view.exit()
      @constructor(@dealer)
    else if @dealer.boardIsFailed()
      @onPressExitButton()
    @view.render()

  onPressSkipRoundButton: ->
    @dealer.round()
    @view.render()

  onPressItemUseButton: (item)->
    command = new Command.UseItem(@_hero(), item)
    @dealer.round(command)
    @view.render()

  onPressSkillButton: (skill)->
    command = new Command.UseSkill(@_hero(), skill)
    @dealer.round(command)
    @view.render()

  _hero: ->
    @dealer.board.getHero()
