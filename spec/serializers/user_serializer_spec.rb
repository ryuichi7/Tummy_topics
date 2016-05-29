require 'rails_helper'

describe 'user_serializer' do

	context '.thumb' do
		it 'properly formats default thumb for json' do
			@user = User.create(
				email: "brett",
				password: "brett1234",
			)
			
			@user_serializer = UserSerializer.new(@user)

			expect(@user_serializer.thumb).to eq "/assets/thumb/placeholder_image.png" 
		end
	end
end