_ = require('underscore')

module.exports = class Player
  constructor: ()->
    @hand = []

  assign: (character)->
    @hand.push(character)

  characters: ->
    @hand

  direction: (character)->
    _.sample ['up', 'down', 'left', 'right']
