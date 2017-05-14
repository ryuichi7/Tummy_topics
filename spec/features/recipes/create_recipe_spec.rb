require 'pry'
include Warden::Test::Helpers
Warden.test_mode!

feature 'create recipe' do

  after(:each) do
    Warden.test_reset!
  end

	scenario 	'creates a new recipe with ingredients' do
		@user = User.create(email: "test@mail.com", password: "test1234")

		visit new_user_session_path
		fill_in 'Email', with: "test@mail.com"
		fill_in 'Password', with: "test1234"


		click_button 'Log in'	
		visit new_recipe_path
		fill_in 'recipe_name', with: 'cookies'
		fill_in 'recipe_description', with: 'yummy'
		fill_in 'recipe_directions', with: 'make them taste good'

		fill_in 'recipe_ingredients_attributes_name', with: "Salt"

		click_button 'Create Recipe'
		@recipe = Recipe.last
		
		expect(page).to have_content('Cookies')
		expect(page).to have_content('Salt')
		expect(@recipe.ingredients.size).to eq(1)
		  
  end

  


  	
end

