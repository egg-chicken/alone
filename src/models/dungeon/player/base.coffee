_ = require('underscore')
Strategy = require('./strategy')

module.exports = class BasePlayer
  constructor: ->
    @hand = []
    @strategies = {}

  assign: (character)->
    if character instanceof Array
      @hand = @hand.concat(character)
    else
      @hand.push(character)

  characters: ->
    _.filter @hand, (character)-> not character.isDead()

  command: (character, inspector)->
    @_pickStrategy(character).createCommand(inspector)

  clearHand: ->
    @hand = []
    @strategies = {}

  _pickStrategy: (character) ->
    @strategies[character.getId()] ||= new Strategy(character)
