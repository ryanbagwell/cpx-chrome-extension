JobTaskCollection = TaskCollection.extend(
  url: '/lookup_tasks.htm'
  query: ->
    @fetch data:
      'J_NUM': @options.jobNumber
      'task_field': 'add_time.COST_TASK'
      'job_field': 'add_time.COST_JOB_NUM'
    return
)
