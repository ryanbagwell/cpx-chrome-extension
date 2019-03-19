$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'
BaseCollection = require './collection.base'
require 'backbone-fetch-cache'

class TaskModel extends Backbone.Model

  defaults:
    number: ''
    client: ''
    name: ''
    team: ''
    priority: ''

class TaskCollection extends BaseCollection

  name: 'TaskCollection'

  model: TaskModel

  url: '/lookup_task_table'

  parse: (html) ->
    $rows = $(html).find('table tr')
    $rows.find('tr').first().remove()
    $.map $rows, (row) ->
      {
        task: $(row).find('td:eq(0)').text()
        name: $(row).find('td:eq(1)').text()
        group: $(row).find('td:eq(2)').text()
        kind: $(row).find('td:eq(3)').text()
      }

  getAutoCompleteList: ->

    @filter((job) -> job.get('task') != 'NONE')
    .map (job) ->
      {
        label: job.get('name')
        value: job.get('task')
      }

module.exports = TaskCollection
