# Require npm and extermal modules
express = require 'express'
path = require 'path'
bodyParser = require 'body-parser'

# Create app instance
app = express()

# Define static paths
# This makes the node modules directory available in the HTML templates
# (Not being used here)
app.use '/node_modules', express.static path.join(__dirname, '../node_modules')

# Attach body parser middleware
# This middleware parses the HTTP Request bodies as JSON objects
# to make them easier to use
app.use bodyParser.json()

# Create the API Router
api = express.Router()
api.get '/test', (req, res, next) ->
  res.status(200).json { message: 'This test API endpoint works!' }

# Attach the API router to the app, prefix all of the api routes with /api
app.use '/api', api

# Send index back for any route hit
app.get '*', (req, res, next) ->
  res.status(404).json { error: "404 Error: #{req.originalUrl} Not Found." }

# Listen for commands on the env-specified port (default 8000)
unless module.parent?
  port = process.env.PORT or 8000
  app.listen port, () ->
    console.log "Learning Backend Launched on port: #{port}..."

# Used for testing
module.exports = app
