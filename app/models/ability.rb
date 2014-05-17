class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post
    can :comment, Post
    can :create, Comment
    return unless user

    can :manage, :all
    cannot :destroy, user
  end
end
