express = require 'express'
url = require 'url'
path = require 'path'
app = express()

monthnames = ["January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December"
]

app.set 'view engine', 'pug'
app.set 'views', path.join __dirname, 'templates'
app.use express.static path.join __dirname, "public"

unixTime = (time) ->
  time.getTime() / 1000

formatTime = (time) ->
  if not isNaN time.getMonth()
    "#{monthnames[time.getMonth()]} #{time.getDate()}, #{time.getFullYear()}"
  else
    null

app.get '/:date', (req, res) ->
  unix = req.params.date * 1000

  if isNaN unix
    date = new Date req.params.date
  else if not isNaN unix
    date = new Date unix
  else
    date = null

  sol =
    unix : unixTime date
    normal : formatTime date

  res.send sol

app.get '/', (req, res) ->
  console.log(req.param)
  res.render 'index'

app.listen process.argv[2]
console.log "Server running on port #{process.argv[2]}"
