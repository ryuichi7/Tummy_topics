FactoryGirl.define do
  factory :recipe do
    name "MyString"
    directions "MyString"
    description "yummy"
    ingredients [FactoryGirl.create(:ingredient)]
  end
end
