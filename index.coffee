express = require 'express.io'

ECT = require 'ect' 
ectRenderer = ECT { watch: true, root: "#{__dirname}/views" }

# moment = require 'moment'
# moment.lang("es")
app = express()
app.http().io()
cool = require('cool-ascii-faces')

app.set 'port', process.env.PORT or 5000
app.set 'views', "#{__dirname}/public/views"
app.engine '.ect', ectRenderer.render
# app.engine 'ect', consolidate.ect
app.set 'view engine', 'ect'
# use middlewares express.
app.use express.static("#{__dirname}/public")
# para ler los campos POST.
# app.use(express.bodyParser()) equivale alas siguientes 3 lineas.
app.use(express.json());
app.use(express.urlencoded());
# app.use(express.multipart());

app.use(express.cookieParser())
app.use express.session(secret: '023197422617bce43335cbd3c675aeed')
app.use express.logger('dev')


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
		response.render 'users', {title:'Usuarios', usuarios:docs}
  	# response.json(docs)

app.listen app.get('port'), ->
  console.log("Node app is running at localhost:" + app.get('port'))
