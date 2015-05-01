TaskModel = Backbone.Model.extend(defaults:
  number: ''
  client: ''
  name: ''
  team: ''
  priority: '')
TaskCollection = BaseCollection.extend(
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
    @map (job) ->
      {
        label: job.get('name')
        value: job.get('task')
      }
)
