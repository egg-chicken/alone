# 情報取得のインターフェースを持つだけの抽象クラス
module.exports = class Command
  perform:         -> throw new Error("cannot perform empty command; override me")

  getAction:       -> @constructor.name.toLowerCase()
  getActor:        -> @actor
  getTarget:       -> @target
  getItem:         -> @item
  getDirection:    -> @direction
  getPoint:        -> @point
  getFailedReason: -> @failed?.toString() || ""

  isDefeated: -> @defeated
  isReached:  -> @reached
  isGameOver: -> @defeated && @target.isHero()
  isFailed:   -> @failed?

  toString: ->
    s = @getActor().getUniqueName?()
    v = @getAction()
    o = @getTarget()?.getUniqueName() || @getDirection() || @getItem()?.getFullName()
    "#{s} #{v} #{o} #{@getFailedReason()}"
