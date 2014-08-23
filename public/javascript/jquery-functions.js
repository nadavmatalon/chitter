
$.ajaxSetup ({  
 cache: false  
});

$(document).ready(function() { 
	update_time();
});

function update_time() {
	$.get("/update", function(data) {
		$("#update-div").html(data);
		window.setTimeout(update_time, 2000);
	}, 'text');
}
