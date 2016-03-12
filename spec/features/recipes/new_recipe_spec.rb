include Warden::Test::Helpers
Warden.test_mode!

feature 'create recipe' do

	let(:user) { User.create(email: "test@mail.com", password: "test1234") }

  after(:each) do
    Warden.test_reset!
  end

	scenario 	'creates a new recipe with ingredients' do
		login_as(User.first)
		  	
		visit 'recipes/new'
		fill_in 'Recipe name', with: 'cookies'
		fill_in 'description', with: 'yummy'
		fill_in 'directions', with: 'make them taste good'

		fill_in 'ingredient_attributes_0_ingredient', with: '1 tbs. / salt\r\n 3 / carrots\n\r 2 / zuchinnis'

		click_button 'Create Recipe'

		expect(page).to have_content('cookies')
		expect(page).to have_content('zuchinni')
		  
  end


  	
end

