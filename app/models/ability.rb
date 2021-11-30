# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)   
    user ||= User.new # guest user (not logged in)
    #binding.pry
    if user.present?
      if user.manager?
        can :manage, Project
        can [:update,:destroy], Project, :user_id => user.id
       
      end
      if user.qa?
        can :read, Project
        can [:create,:read,:update] , Bug
        can :destroy, Bug , user_id: user.id
      end
      if user.developer?
        can :read, Project
        can :read, Bug
        can :update, Bug , assigned_to: user.id
      end
    else
      can :read, :all
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
