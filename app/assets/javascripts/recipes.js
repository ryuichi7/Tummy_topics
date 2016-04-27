// Models and prototypes //

String.prototype.capitalize = function() {
	return this.charAt(0).toUpperCase() + this.slice(1)
}

String.prototype.titleize = function() {
	var words = this.split(" ");
	return words.map(function(word) {
		return word.capitalize();
	}).join(" ")
}

function Recipe(id, name, directions, description, user, createdAt, comments = null, ratings = null) {
	this.id = id
	this.name = name
	this.directions = directions
	this.description = description
	this.user = user
	this.createdAt = createdAt
	this.comments = comments
	this.ratings = ratings
}

Recipe.prototype.userName = function() {
	return this.user.email.split("@")[0]
}

Recipe.prototype.ratingAvg = function() {
	var sum = 0
	this.ratings.forEach(function(rating){
		sum += rating.score
	})
	return sum/this.ratings.length
}

function formattedDate(date) {
  var d = new Date(date || Date.now()),
      month = '' + (d.getMonth() + 1),
      day = '' + d.getDate(),
      year = d.getFullYear();

  if (month.length < 2) month = '0' + month;
  if (day.length < 2) day = '0' + day;

  return [month, day, year].join('/');
}

function createRecipe(recipe) {
	var newRecipe = new Recipe(
				recipe.id,
				recipe.name,
				recipe.directions,
				recipe.description,
				recipe.user,
				recipe.created_at,
				recipe.comments,
				recipe.ratings
	);
	return newRecipe;
}

function formatForTemplate(recipe) {
	var values = {
					id: recipe.id,
					user_id: recipe.user.id,
					name: recipe.name.titleize(),
					userName: recipe.userName(),
					body: formattedDate(recipe.createdAt)
	};
	if (recipe.ratings.length > 0) {
		values["rating"] = recipe.ratingAvg()
	};
	if (recipe.comments.length > 0) {
		values["comments"] = recipe.comments
	};
	return values;
}



// Error Handling //

$(document).bind('ajaxSuccess','form#new_comment', function(event, xhr, settings) {
	if (settings.url === '/comments') {
		$('.form-group.has-error').each(function(){
	    $('.help-block', $(this)).html('');
	    $(this).removeClass('has-error');
	  });
	  alert("Thanks for your comment!");
	}
})
.bind('ajaxError','form#new_comment', function(event, xhr, settings) {
		$('textarea#comment_content').closest(".form-group").addClass('has-error')
		.find('.help-block').html($.parseJSON(xhr.responseText).content);
})


// Loaded document actions //

$(document).ready(function() {
	$("button#button").click(function(event) {
		$.get($(this).data('url'), function(response) {
			$('#new-form').append(response);
		})
		event.preventDefault();
	})
});

$(window).bind('page:change', function() {
	var recipes = [];
	var source = $("#recipe-template").html();
	var template = Handlebars.compile(source);

	$('form#search_form').on('submit', function(e) {
		e.preventDefault();
		var values = $(this).serialize();
		$.post('/search', values)
		.done(function(response) {
			$("div#recipes").empty();
			if (response.search.length > 0) {
				response.search.forEach(function(recipe) {
					values = formatForTemplate(createRecipe(recipe));
					$('#recipes').append(template(values));
				})
			} else {
				$('#recipes').html("<div class='alert alert-danger' role='alert'><strong>Sorry no results found. Please refine your search</strong></div>")
			}
		})
	})


	$('body').on('click', 'div.panel-heading:first h2', function() {
		$("div.panel-body:first").toggle(1000);
	});

	$("button#button").click(function(event) {
		$.get($(this).data('url'), function(response) {
			$('#new-form').append(response);
		})
		event.preventDefault();
	})

	$(document).on('mouseover', 'button#see-comments', function() {
		$(this).siblings('div#comments-list').toggleClass();
	})


	var data = { limit: 0 }
	// $.get('/recipes.json', data, function(response) {
	// 	response.recipes.forEach(function(recipe) {
	// 		var newRecipe = createRecipe(recipe);
	// 		recipes.push(newRecipe);
	// 		$('#recipes').append(template(formatForTemplate(newRecipe)))
	// 	})
	// })

	$('a#load').on("click", function(e) {
		e.preventDefault();
		data["limit"] += 9;
		$.get('/recipes.json', data, function(response) {
			response.recipes.forEach(function(recipe) {
				var newRecipe = createRecipe(recipe);
				recipes.push(newRecipe);
				$('#recipes').append(template(formatForTemplate(newRecipe)))
			})
		})
	})			
});
