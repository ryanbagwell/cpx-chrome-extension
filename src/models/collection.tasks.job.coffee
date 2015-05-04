$ = require 'jquery'
_ = require 'underscore'
TaskCollection = require './collection.tasks'


class JobTaskCollection extends TaskCollection

  url: '/lookup_tasks.htm'

  fetch: (opts={}, data) ->

    defaultData =
      'J_NUM': null
      'task_field': 'add_time.COST_TASK'
      'job_field': 'add_time.COST_JOB_NUM'

    data = _.extend defaultData, data

    if data.J_NUM is null
      console.error 'You must provide a job number to retrieve tasks.'
      return

    opts.data = data

    super(opts)

  parse: (html) ->

    $rows = $(html).find('td.tablemidd table tr').filter('[class!="tablehead"]')

    _.map $rows, (row) ->
      {
        task: $(row).find('td:eq(0)').text()
        name: $(row).find('td:eq(1)').text()
        group: $(row).find('td:eq(2)').text()
        kind: $(row).find('td:eq(3)').text()
      }

module.exports = JobTaskCollection
