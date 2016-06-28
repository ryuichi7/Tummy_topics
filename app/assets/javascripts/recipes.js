// Models and prototypes //

function inGroupsOf(array, number, fillWith) {
   fillWith = fillWith || null;
   var index = -number, slices = [];

   if (number < 1) return array;

   while ((index += number) < array.length) {
       var s = array.slice(index, index + number);
       while(s.length < number)
           s.push(fillWith);
       slices.push(s);
   }
   return slices;
};

String.prototype.capitalize = function() {
	return this.charAt(0).toUpperCase() + this.slice(1)
}

String.prototype.titleize = function() {
	var words = this.split(" ");
	return words.map(function(word) {
		return word.capitalize();
	}).join(" ")
}

function Recipe(id, name, directions, description, user, postDate, comments = null, ratings = null, image) {
	this.id = id
	this.name = name
	this.directions = directions
	this.description = description
	this.user = user
	this.postDate = postDate
	this.comments = comments
	this.ratings = ratings
	this.image = image
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
		recipe.post_date,
		recipe.comments,
		recipe.ratings,
		recipe.image
	);
	return newRecipe;
}

function formatForTemplate(recipe, openRow = false, closeRow = false) {
	var values = {
		name: recipe.name.titleize(),
		recipe: recipe,
		user: recipe.user
	};

	if (recipe.ratings.length > 0) {
		values["rating"] = recipe.ratingAvg();
		values["ratingLength"] = recipe.ratings.length;
	};
	if (openRow === true) {
		values["open"] = true;
	};
	if (closeRow === true) {
		values["close"] = true;
	};
	return values;
};


function displayRating() {
	$('.display-rating').raty({
		readOnly: true,
  	score: function() {
    	return $(this).attr('data-rating');
	  }
	});	
};

function navScrollFill(trigger) {
	$(window).scroll(function() {
    if ($(document).scrollTop() > trigger) { 
      $(".navbar").css("background", "#f8f8f8");
    } else {
      $(".navbar").css("background", "rgba(255, 255, 255, 0.6)");
    }
  });
}

function addRecipeForm() {
	$("button#get-form").click(function(e) {
		var button = $(this);
		$.get($(this).data('url'), function(response) {
			$(button).parent().siblings().find('.ingredient-form').append(response);
		});
		e.preventDefault();
	});
}

function parseAndDisplay(recipes) {
	inGroupsOf(recipes, 3).forEach(function(group) { 
		var source = $("#recipe-template").html();
		var template = Handlebars.compile(source);
		var recipeRow = '<div class="row">';
		group.forEach(function(recipe) {
			if (recipe !== null) {
				var rec = createRecipe(recipe);

				recipeRow += template(formatForTemplate(rec));
			}
		});
		recipeRow += '</div>';
		$('#recipes').append(recipeRow);
		displayRating();
	});
}

function searchRecipes() {
	$('form#search_form').on('submit', function(e) {
		$('#recipes').data('is-searched', true);
		e.preventDefault();
		
		var data = $(this).serialize(), limit = { "limit": 0 }, form = this;
		
		$(form).data('search-limit', 0);
	
		data = data + '&limit=' + limit["limit"]

		$("div#recipes").empty();
		postSearch(data);
	});
}

function postSearch(data) {
	$.post('/search', data).done(function(response) {
		
		$('form').data('current-query', $('input#query').val())
		
		if (response.search.length > 0) {
			var recipes = response.search;
			parseAndDisplay(recipes);
			$('.result-box').html('<h2>Results for: ' + $('input#query').val() + '</h2>');
			$('.alert').remove();
		} else if ($('form').data('search-limit') === 0) {
			$('.alert').remove();
			$('.result-box').empty();
			$('#recipes').before('<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>Sorry no results found. Please refine your search</div>')
		}
	});
}

// Loaded document actions //

$(document).ready(function() {
	
	// append extra ingredient forms to DOM
	addRecipeForm();
	
	// display stars for ratings
	displayRating();

});







