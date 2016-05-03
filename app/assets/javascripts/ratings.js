$(function() {
	$('#star').raty({
		scoreName: 'rating[score]'
	});

	$('form#new_rating').on('submit', function(e) {
		e.preventDefault();
		if ($('#star').data('rated') === false) {
			var values = $(this).serialize();
			
			$.post('/ratings', values).done(function(response) {
				$("#rating").children('.panel-body').prepend('<div class="alert alert-success alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>Thanks for your rating!</div>');
				$('#star').raty('reload');
				$("#star").parent().removeClass("has-error").find(".help-block").html('');
				$('#star').data('rated', 'true');
			}).fail(function(response) {
				$("#star").parent().addClass("has-error").find(".help-block").html(response.responseJSON.score[0])
			})
		} else {
			$('.alert').remove();
			$("#rating").children('.panel-body').prepend('<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>You can only rate a recipe once!</div>');
		}

	});
});