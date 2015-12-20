module.exports = class GameOverView
  render: ->
    termCode = '\u001B[2J\u001B[0;0f'
    process.stdout.write(termCode)
    console.log("\n\n\n\n    GAME OVER\n\n\n\n")
