module.exports = class Buffer
  TYPES =
    ATTACK: 0
    DIFFENCE: 1
  @createDiffenceBuffer: (point, duration)->
    new Buffer(TYPES.DIFFENCE, point, duration)

  constructor: (@type, @point, @duration)->

  isAttackBuffer: ->
    @type == TYPES.ATTACK

  isDiffenceBuffer: ->
    @type == TYPES.DIFFENCE

  isExpired: ->
    @duration <= 0

  activate: ->
    @duration -= 1
    @point

  getSymbol: ->
    switch(@type)
      when TYPES.ATTACK   then 'A'
      when TYPES.DIFFENCE then 'D'
