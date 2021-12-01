

class Ability
  include CanCan::Ability

  def initialize(user)   
    user ||= User.new 
    
    if user.present?
      if user.manager?
        can [:read,:create] , Project
        can [:update,:destroy], Project, :user_id => user.id
       
      end
      if user.qa?
        can :read, Project
        can [:create,:read,:update] , Bug
      # can :destroy, Bug , user_id: user.id
      end
      if user.developer?
        can :read, Project
        can :read, Bug
        can :update, Bug , assign_to: user.id
      end
    else
      can :read, :all
    end

    
  end
end
