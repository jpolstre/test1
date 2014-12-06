express = require('express')
app = express()
cool = require('cool-ascii-faces')

app.set('port', (process.env.PORT or 5000))

app.get '/', (request, response)->
  response.send(cool())

app.listen app.get('port'), ->
  console.log("Node app is running at localhost:" + app.get('port'))
