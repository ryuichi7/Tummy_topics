FactoryGirl.define do
  factory :recipe do
    name "MyString"
    directions "MyString"
    description "yummy"
    ingredients_attributes [name: 'cucumber']
  end
end

