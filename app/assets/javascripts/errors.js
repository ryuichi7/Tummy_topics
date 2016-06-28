// Error Handling //

$(document).bind('ajaxSuccess','form#new_comment', function(event, xhr, settings) {
	if (settings.url === '/comments') {
		$('.form-group.has-error').each(function(){
	    $('.help-block', $(this)).html('');
	    $(this).removeClass('has-error');
	  });
	}
})
.bind('ajaxError','form#new_comment', function(event, xhr, settings) {
	if (settings.url === '/comments') {
		$('.alert').remove();
		if (xhr.status === 500) {
			$("#comment_form").children('.panel-body').prepend('<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>Please sign in to create a comment!</div>');
		} else {
			$('textarea#comment_content').closest(".form-group").addClass('has-error')
			.find('.help-block').html($.parseJSON(xhr.responseText).content);
		};
	}
})

$.prototype.clear_previous_errors = function () {
  $('.form-group.has-error', this).each(function(){
    $('.help-block', $(this)).remove();
    $(this).removeClass('has-error');
  });
}