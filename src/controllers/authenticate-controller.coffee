redis             = require 'redis'
RedisNS           = require '@octoblu/redis-ns'
Authenticator     = require '../models/authenticator'
MeshbluAuthParser = require '../helpers/meshblu-auth-parser'
debug = require('debug')('meshblu-http-server:authenticate-controller')

class AuthenticateController
  constructor: ({@timeoutSeconds}={})->
    @timeoutSeconds ?= 30

  authenticate: (request, response) =>
    {uuid,token} = new MeshbluAuthParser().parse request

    authenticator = new Authenticator client: request.connection, timeoutSeconds: @timeoutSeconds
    authenticator.authenticate uuid, token, (error, authResponse) =>
      return response.status(502).end() if error?
      response.status(authResponse.metadata.code).end()

module.exports = AuthenticateController
