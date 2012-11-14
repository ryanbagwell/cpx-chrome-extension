    
function CPHelper() {
    this.jobNumber = $('input[name="COST_JOB_NUM"]');
    this.task = $('input[name="COST_TASK"]');
    this.init();
}
CPHelper.prototype.init = function() {
    var me_ = this;
    console.log('init');
    
    this.task.removeAttr('onchange').autocomplete();
    this.jobNumber.removeAttr('onchange').autocomplete();

    var jobs = this.setJobs();
    
    console.log(jobs);
    
    $('input[name="COST_DATE"]').datepicker();
    
    console.log('datepicker');
    
    $('input[name="COST_JOB_NUM"]').removeAttr('onchange').autocomplete({
        source:jobs
    });
    
    console.log('done');
    
    this.jobNumber.blur(function() {
        me_.setTasks();
    });
    
    
    
}
CPHelper.prototype.setTasks = function() {
    
    var jobNo = this.jobNumber.val();
    var url = '/lookup_tasks&'+jobNo;
    console.log(url);
    var tasks = [];
    var me_ = thisl
    
    $.get(url,function(response) {
        
        $(response).find('select option').each(function() {
            var content = $(this).text();
            var parts = content.split('/');
            var taskCode = parts[0].replace(/^\s*|\s*$/g,'');
                    
            t = {
                label:content,
                value:taskCode
            };
            
            tasks.push(j);
  
        });

        me_.jobNumber.autocomplete('option','source',jobs);
    });
    
}


CPHelper.prototype.setJobs = function() {
    var me_ = this;
    var jobs = [];
    
    console.log('set');

    $.get('/lookup_job_tickets', function(response) {
        var options = $(response).find('select option');
    
        $(options).each(function() {
            var content = $(this).text();
            var parts = content.split('/');
            var jobNo = parts[0].replace(/^\s*|\s*$/g,'');
            var jobName = parts[2].replace(/^\s*|\s*$/g,'');
          
            j = {
                label:jobName,
                value:jobNo
            };
            
            jobs.push(j);
            
        });
        
        console.log(me_.jobNumber);
        
        me_.jobNumber.autocomplete('option','source',jobs);
    
    },'html');
    
}
    
jQuery(document).ready(function() {
    var c = new CPHelper();
});