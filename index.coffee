express = require 'express.io'

ECT = require 'ect' 
ectRenderer = ECT { watch: true, root: "#{__dirname}/views" }

# moment = require 'moment'
# moment.lang("es")
app = express()
app.http().io()
cool = require('cool-ascii-faces')

cool = require('cool-ascii-faces')

app.set('port', (process.env.PORT or 5000))

mongoose = require('mongoose')
mongoose.connect('mongodb://chelo:corprotec@ds061360.mongolab.com:61360/corprotec')

getModel = ->
	model = undefined
	UserSchema = mongoose.Schema
		name: String
		password: String
		email: String
		estado: String
		privilegios: []#puede ser tambien []
		conectado:{type:String, default:'off'}

	if mongoose.modelNames().indexOf('User') is -1#si no existe creamos el esquema.
		model = mongoose.model('User', UserSchema)
	else
		model = mongoose.model('User')
	#si existe enviamos el ya creado.
	model	



app.get '/', (request, response)->
  response.send(cool())

app.get '/users', (request, response)->
	modelUser = getModel()
	modelUser.find({}).exec (err, docs)->
  	response.json(docs)

app.listen app.get('port'), ->
  console.log("Node app is running at localhost:" + app.get('port'))
