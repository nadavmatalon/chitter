$(document).ready(function() {

	// $.ajaxSetup ({  
	//  cache: false  
	// });

	// $(document).ready(function() { 
	// 	update_time();
	// });

	// function update_time() {
	// 	$.get("/update", function(data) {
	// 		$("#update-div").html(data);
	// 		window.setTimeout(update_time, 2000);
	// 	}, 'text');
	// }

	$('#sign-in-window').click(function() {		
		var signInBox = $('.sign-in-popup');
		$(signInBox).fadeIn(200);
		var marginTop = ($(signInBox).height() + 24) / 2; 
		var marginLeft = ($(signInBox).width() + 24) / 2; 	
		$(signInBox).css({ 
			'margin-top': -marginTop,
			'margin-left': -marginLeft
		});		
		$('#mask').removeClass('hiding');		
		$('#mask').addClass('showing');		
		return false;
	});
	$('#close-button, #mask').on('click', function() { 
	  $('.sign-in-popup').fadeOut(200);
	  $('#mask').removeClass('showing'); 
	  $('#mask').addClass('hiding'); 
	return false;
	});
});
