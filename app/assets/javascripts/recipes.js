

// var newForm = '<div class="form-group"><%= ingredients.label "Add Ingredients: Please put each ingredient on a separate line", autofocus: true %><br><p>( add a " - " between measurment and ingredient )</p><%= ingredients.text_area :ingredients, cols: 55, rows: 10, placeholder: "ex: 1 1/2 cups - flour", class: "form-control" %><br></div>'

// $(document).ready(function() {
// 	$("#button").click(function(event) {
// 		$("#new-form").append(newForm);
// 		event.preventDefault();
// 	})

// });


$(document).ready(function() {
		$('body').on('click', 'div.panel-heading:first h2', function() {
			$("div.panel-body:first").toggle(1000);
		});



	$("#button").click(function(event) {
		$.get($(this).data('url'), function(response) {
			$('#new-form').append(response);
		})
		// var $button = $(this);
		// // var url = $button.data("url")
		
		// var source   = $("#ingredient-template").html();
		// var template = Handlebars.compile(source);

		// $button.before(template())
		// $.get(url, function(response){
		// 	console.log(response)
		// 	$button.before(response)
		// })

		event.preventDefault();
	})

});

function hideSearch() {
	$("div.panel-heading:first h2").click(function() {
		$("div.panel-body:first").toggle(1000);
	});
}

$(window).bind('page:change', function() {
 $('body').on('click', 'div.panel-heading:first h2', function() {
		$("div.panel-body:first").toggle(1000);
	});
})