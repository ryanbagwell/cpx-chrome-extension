var JobTicket = Backbone.Model.extend({
		defaults: {
			number: '',
			client: '',
			name: '',
			team: '',
			priority: ''
		},
});

var JobTickets = Backbone.Collection.extend({
	
	model: 'JobTicket',
	
	dataType: 'html',
	
	url: '/lookup_job_tickets',

	sync: function(method, model, options) {
		var options = $.extend({
			dataType: 'html',
			parse: this.parse
			}, options);
		return Backbone.sync.call(this, method, model, options);

	},
	
	parse: function(html) {
		var $rows = $(html).find('table tr');
		$rows.find('tr').first().remove();
		
		return $.map($rows, function(row) {
			var m = {
				number: $(row).find('td:eq(0) a').text(),
				client: $(row).find('td:eq(1) a').text(),
				name: $(row).find('td:eq(2)').text(),
				team: $(row).find('td:eq(3)').text(),
				priority: $(row).find('td:eq(4)').text()
			}
			console.log(m);
			return m;
			
		});
	}
});