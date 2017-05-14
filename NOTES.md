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



todo:

1. ~~get rid of nested routes for user~~
2. ~~make modal for user to edit recipe? or give editing capabilites~~
3. ~~finish ansynchronous rating abilities~~
4. ~~ability to search by rating?~~
5. ~~fix load comments button. should only show when there are more items to be loaded~~

6. why can't I delete comment right after creation with remote: true?
7. recipe ingredients attributes: find better way to deal with updating field(not using #persisted?)
8. ~~put number of ratings next to rating in display~~
9. ~~put number of recipes next to user display ~~
10. ~~create popovers on index page that displays truncated version of recipe.~~
11. add footer
12 use dotenv gem for storing facebook data
13.try to use google api for authentication?
14. ~~keep users from being able to vote more than once. use query to see if rater is included in recipe's ratings. or set some sort of boolean on one of the models?~~



~~fix error fields~~
~~refactor controllers create action to use. (i.e. current_user.build_recipe...)~~

Questions for peter:

-why can't I delete comment right after creation with remote: true?
- some thoughts on remote: true? am I rendering errors in an ideal fashion?
-recipe ingredients attributes: find better way to deal with updating field(not using #persisted?)
-use cucumber or possibly protractor for BDD? want to test asynchronous db queries on recipe index page.
- how can I beter organize my js files?
- how an I create better search functionality?

