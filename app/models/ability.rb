class Ability
  include CanCan::Ability

  def initialize(user)
    # user ||= User.new
    alias_action :search, to: :read

    can :read, [ Recipe, Comment, Ingredient]
    
    if !user.nil?
        can :manage, Recipe, user: user
        can :manage, Comment, commenter: user
        can :create, Rating, rater: user
    end
    
  end
end
