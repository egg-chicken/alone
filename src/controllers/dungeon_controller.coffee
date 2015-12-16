Command  = require('models/command/')

module.exports = class DungeonController
  constructor: (@dealer, @view)->

  control: ()->
    @view.on('press:exit-button', =>@onPressExitButton())
    @view.on('press:item-use-button', (item)=>@onPressItemUseButton(item))
    @view.on('press:move-button', (button)=>@onPressMoveButton(button))
    @view.on('press:skill-button', (button)=>@onPressSkillButton(button))
    @view.on('press:skip-round-button', (button)=>@onPressSkipRoundButton(button))

  onPressExitButton: ->
    @view.removeAllListeners()
    process.exit()

  onPressMoveButton: (direction)->
    command = new Command.MoveOrAttack(@_hero(), direction)
    @dealer.round(command)
    if @dealer.boardIsCompleted()
      @onCompleteBoard()
    else if @dealer.boardIsFailed()
      @onFailedBoard()
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

  onCompleteBoard: ->
    throw new Error("please override me")

  onFailedBoard: ->
    throw new Error("please override me")

  _hero: ->
    @dealer.board.getHero()
