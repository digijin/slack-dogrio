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

	
	user = req.body.user_id

	if user
		if user is "USLACKBOT"
			res.send "hi slackbot"
			return

	text = req.body.text

	if text
		# parse text here
		text = text.replace 'wow ', 'wow/'
		text = text.replace ' such', '/such'
		text = text.replace ' much', '/much'
		text = text.replace ' very', '/very'
		text = text.replace ' many', '/many'

		text = text.replace ' ', ''


		reply = {
			text
		}

		res.send JSON.stringify reply
	else
		res.send out
	
app.get '/', (req, res) ->
	# console.log req
	res.send out

port = process.env.PORT or 5000
app.listen port