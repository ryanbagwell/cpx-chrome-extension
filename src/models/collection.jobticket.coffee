$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'
BaseCollection = require './collection.base'


class JobTicketModel extends Backbone.Model

  defaults:
    number: ''
    client: ''
    name: ''
    team: ''
    priority: ''

class JobTicketCollection extends BaseCollection

  name: 'JobTicketCollection'

  model: JobTicketModel

  url: '/lookup_job_tickets'

  parse: (html) ->
    $rows = $(html).find('table tr')

    $rows.find('tr').first().remove()

    $.map $rows, (row) ->
      {
        number: $(row).find('td:eq(0) a').text()
        client: $(row).find('td:eq(1) a').text()
        name: $(row).find('td:eq(2)').text()
        team: $(row).find('td:eq(3)').text()
        priority: $(row).find('td:eq(4)').text()
      }

  getAutoCompleteList: ->

    @map (job) ->
      {
        label: job.get('name')
        value: job.get('number')
      }

module.exports = JobTicketCollection
