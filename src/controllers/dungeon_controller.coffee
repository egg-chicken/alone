Command  = require('models/dungeon/command/')

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
    hero    = @dealer.getPlayer().getHero()
    command = new Command.MoveOrAttack(hero, direction)
    @_playRound(command)

  onPressItemUseButton: (item)->
    hero    = @dealer.getPlayer().getHero()
    command = new Command.UseItem(hero, item)
    @_playRound(command)

  onPressSkillButton: (skill)->
    hero    = @dealer.getPlayer().getHero()
    command = new Command.UseSkill(hero, skill)
    @_playRound(command)

  onPressSkipRoundButton: ->
    @_playRound(null)

  onCompleteBoard: ->
    throw new Error("please override me")

  onFailedBoard: ->
    throw new Error("please override me")

  _playRound: (command)->
    @dealer.getPlayer().setCommand(command)
    @dealer.round(command)
    @view.render()
    if @dealer.boardIsCompleted()
      @onCompleteBoard()
    else if @dealer.boardIsFailed()
      @onFailedBoard()
