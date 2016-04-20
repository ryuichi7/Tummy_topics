include Warden::Test::Helpers
Warden.test_mode!

feature 'display recipes' do
	let(:user) { User.create(email: "joe@mail.com", password: "test1234") }
	let(:recipe) { Recipe.create(name: 'yum', directions: 'cook it', description: 'yummy', ingredients_attributes: [ name: "cucumber" ], user: user )}

  after(:each) do
    Warden.test_reset!
  end

  scenario "index page doesnt break without recipes to display" do
  	visit '/recipes'
  	expect(page).to have_content("no recipes to display")
  end

  scenario "properly displays recipes on page" do
  	recipe
  	visit '/recipes'
  	expect(page).to have_content(recipe.name.titleize)
  end

end
