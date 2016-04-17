
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
	return values;
}





$(window).bind('page:change', function() {
	var recipes = [];
	var source = $("#recipe-template").html();
	var template = Handlebars.compile(source);

	$(function() {
		$('form#search_form').on('submit', function(e) {
			e.preventDefault();
			var values = $(this).serialize();
			$.post('/search', values)
			.done(function(response) {
				$("div#recipes").empty();
				response.search.forEach(function(recipe) {
					values = formatForTemplate(createRecipe(recipe));
					$('#recipes').append(template(values));

				})
			})
		})
	})

	$('body').on('click', 'div.panel-heading:first h2', function() {
		$("div.panel-body:first").toggle(1000);
	});

	$("#button").click(function(event) {
		$.get($(this).data('url'), function(response) {
			$('#new-form').append(response);
		})
		event.preventDefault();
	})

	$.get('/recipes.json', function(response) {
		response.recipes.forEach(function(recipe) {
			var newRecipe = createRecipe(recipe);
			recipes.push(newRecipe);
			$('#recipes').append(template(formatForTemplate(newRecipe)))
		})
	})			
});
