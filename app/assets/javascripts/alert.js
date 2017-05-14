function alertTimeout() {
	$(".alert").delay(4000).slideUp(500, function() {
	    $(this).alert('close');
	});
}
