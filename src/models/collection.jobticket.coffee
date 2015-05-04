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

    $rows = $(html).find('td.tablemid table tr')

    $rows.first().remove()

    _.map $rows, (row) ->
      {
        number: $(row).find('td:eq(0) a').text()
        client: $(row).find('td:eq(1) a').text()
        name: $(row).find('td:eq(2)').text()
        team: $(row).find('td:eq(3)').text()
        priority: $(row).find('td:eq(4)').text()
      }

  getAutoCompleteList: ->

    if @length is 0
      @fetch()

    mapped = @map (job) ->

      if job.get('number')

        return {
          label: "#{job.get('name')} (#{job.get('number')})"
          value: job.get('number')
        }

      else
        null

    _.compact mapped

module.exports = JobTicketCollection
