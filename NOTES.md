1 The browser makes a request

2. Rails Initial HTML payload
	/url
	Controller#action
	Layout
		application.js - shouldn't to the rails stack (no models, very little to no ruby)
		View


AJAX + HTML RESPONSES
	we load the initial form with 1 field for more ingredients on initial payload

	when they click on that button, we're going to ask the server for more html via AJAX and then drop that into the HTML
		/recipes/ingredients/new
		recipe.js - click even, fire the ajax, process the response


AJAX + JS - getScript or Remote True
	click the link, ask the server for more JS




1. Event handler
2. Fire a request
3. do something with the response (inject HTML into the DOM or evaluate Javascript or process JSON and generally inject Html to the dom)