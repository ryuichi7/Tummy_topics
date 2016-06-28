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

  scenario "index page displays only 9 recipes on load" do
    10.times do
      recipe = FactoryGirl.create(:recipe)
      recipe.user = user
      recipe.save
    end
    visit '/recipes'
    expect(page).to have_css('div.col-md-4', count: 9)
  end

end
