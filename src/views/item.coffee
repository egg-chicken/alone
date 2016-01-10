module.exports = class ItemView
  constructor: (@items, @hero)->
    @focus = 0

  getFocusedItem: ->
    @items[@focus]

  up: ->
    @focus = Math.max(0, @focus-1)

  down: ->
    @focus = Math.min(@items.length-1, @focus+1)

  render: ->
    lines = ['ITEM LIST: ']
    lines.push("(empty)") if @items.length == 0

    for i in [0...@items.length]
      item = @items[i]
      symbol = if i == @focus               then '*' else ' '
      equip  = if item == @hero.getWeapon() then 'E' else ' '
      left = "#{symbol} #{equip} #{item.getFullName()}"
      lines.push("#{@_pack(left, 20)}| #{item.getDescription()}")
    console.log(lines.join("\n"))

  _pack: (str, width)->
    while(str.length < width)
      str += ' '
    str
