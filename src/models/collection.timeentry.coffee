Backbone = require 'backbone'
require 'backbone-fetch-cache'

TimeEntryModel = Backbone.Model.extend(defaults:
  start: ''
  end: ''
  jobNumber: ''
  task: '')

module.exports = TimeEntryModel
