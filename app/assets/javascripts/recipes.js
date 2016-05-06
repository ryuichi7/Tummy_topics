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

function formatForTemplate(recipe, openRow = false, closeRow = false) {
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
	if (openRow === true) {
		values["open"] = true;
	};
	if (closeRow === true) {
		values["close"] = true;
	};
	return values;
};

function getMoreRecipes(data) {	
	$.get('/recipes.json', data, function(response) {
		inGroupsOf(response.recipes, 3).forEach(function(group) {
			var source = $("#recipe-template").html();
			var template = Handlebars.compile(source);
			var recipeRow = '<div class="row">';
			group.forEach(function(recipe) {
				var newRecipe = createRecipe(recipe);
				recipeRow += template(formatForTemplate(newRecipe));
			});
			recipeRow += '</div>';
			$('#recipes').append(recipeRow);
			displayRating();
		});
	});	
}		

function displayRating() {
	$('.display-rating').raty({
		readOnly: true,
  	score: function() {
    	return $(this).attr('data-rating');
	  }
	});	
};



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
		$('textarea#comment_content').closest(".form-group").addClass('has-error')
		.find('.help-block').html($.parseJSON(xhr.responseText).content);
	}
})


// Loaded document actions //

$(document).ready(function() {

	// append extra ingredient forms to DOM
	$("button#button").click(function(e) {
		$.get($(this).data('url'), function(response) {
			$('#new-form').append(response);
		});
		e.preventDefault();
	});
		// display stars for ratings
	displayRating();


	var recipes = [];
	var source = $("#recipe-template").html();
	var template = Handlebars.compile(source);

	$('form#search_form').on('submit', function(e) {
		e.preventDefault();
		var values = $(this).serialize();

		$.post('/search', values).done(function(response) {
			$("div#recipes").empty();
			if (response.search.length > 0) {
				response.search.forEach(function(recipe) {
					values = formatForTemplate(createRecipe(recipe));
					$('#recipes').append(template(values));
					displayRating();
					$('.alert').remove();
				})
			} else {
				$('.alert').remove();
				$('#recipes').before('<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>Sorry no results found. Please refine your search</div>')
			}
		})
	})


	$('body').on('click', 'div.panel-heading:first h2', function() {
		$("div.panel-body:first").toggle(1000);
	});

	//comment box rendering. revisit this again?

	// $(document).on('mouseover', 'button.see-comments', function() {
	// 	$(this).siblings('div.comments-list').toggleClass('hidden')
	// 	.closest('div.inner-comment-box').css('z-index', 1);
	// })

	// $(document).on('mouseout', 'button.see-comments', function() {
	// 	$(this).siblings('div.comments-list').toggleClass('hidden')
	// 	.closest('div.inner-comment-box').css('z-index', 0);
	// })
	var data = { limit: 0 };

	$('a#get-recipes').on("click", function(e) {
		data["limit"] += 9;
		e.preventDefault();
		getMoreRecipes(data);
	});	
});





