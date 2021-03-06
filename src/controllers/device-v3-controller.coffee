JobToHttp = require '../helpers/job-to-http'
debug = require('debug')('meshblu-core-protocol-adapter-http:get-device-controller')
_     = require 'lodash'

class DeviceV3Controller
  constructor: ({@jobManager, @jobToHttp}) ->

  get: (req, res) =>
    job = @jobToHttp.httpToJob jobType: 'GetDevice', request: req, toUuid: req.params.uuid

    debug('dispatching request', job)
    @jobManager.do job, (error, jobResponse) =>
      return res.sendError error if error?
      @jobToHttp.sendJobResponse {jobResponse, res}

module.exports = DeviceV3Controller
