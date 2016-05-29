class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :thumb, :email_name

  def thumb
  	thumb = object.avatar.url(:thumb)
  	thumb.tap do |avatar_thumb|
  		if avatar_thumb.match(/thumb\/placeholder_image/)
  			return "/assets/#{avatar_thumb}"
  		end
  	end
  end
end
	