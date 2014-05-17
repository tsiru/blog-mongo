class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post
    can :comment, Post
    return unless user

    can :manage, :all
    cannot :destroy, user
  end
end
