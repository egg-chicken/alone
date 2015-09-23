module.exports = class PlayerView
  constructor: (@player)->

  render: ->
    characters = @player.characters()
    lines = []
    lines.push("SCORE: #{@player.getScore()}")
    for i in [0...characters.length]
      lines.push(characters[i].to_s())
    console.log(lines.join("\n"))
