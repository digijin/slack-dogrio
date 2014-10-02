express = require 'express'
bp = require 'body-parser'

fs = require 'fs'

form = fs.readFileSync 'form.html'
	.toString()

console.log "init"
app = express()
app.use bp.json()
app.use bp.urlencoded()
out = form
app.post '/', (req, res) ->
	out += '<br />'
	out += JSON.stringify req.body

	text = req.body.text

	# parse text here

	reply = {
		text: 'much reply'
	}

	# res.send out
app.get '/', (req, res) ->
	# console.log req
	res.send out

port = process.env.PORT or 5000
app.listen port