module.exports = class PlayerView
  constructor: (@player)->

  render: ->
    characters = @player.characters()
    lines = []
    lines.push("SCORE: #{@player.getScore()}")
    for i in [0...characters.length]
      lines.push("HEALTH: #{characters[i].getHealthString()}")
      lines.push("BUFFERS: #{characters[i].getBuffersString()}")
      lines.push("ITEMS: #{characters[i].getItemsString()}")
    console.log(lines.join("\n"))
