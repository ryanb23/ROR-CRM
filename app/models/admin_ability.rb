class AdminAbility
  include CanCan::Ability

  def initialize(user)
    # user.role.permissions.each do |permission|
    #   if permission.subject_class == "all"
    #     can permission.action.to_sym, permission.subject_class.to_sym
    #   else
    #     can permission.action.to_sym, permission.subject_class.constantize
    #   end
    # end
    # can :all, User if user.admin?
    # can :all, User if user.admin?
    # can :read, User if user.admin?
    # can :manage, User if user.admin?

    user.roles.each do |role|
      role.permissions.each do |permission|
        # exit
        if permission.subject_class == "all"
          can permission.action.to_sym, permission.subject_class.to_sym
        else
          can permission.action.to_sym, permission.subject_class.safe_constantize
          # can permission.action.to_sym, permission.subject_class.constantize
        end
        
      end

    end
    
    # user.roles.each do |role|
    #   role.permissions.each do |permission| 
    #     if (permission.subject_class == "Registration" && permission.action == "edit" ) && (permission.subject_class == "Registration" && permission.action == "update" )
    #       can :edit_profile, User
    #       can :update_profile, User
    #     elsif permission.subject_class == "Registration" && permission.action == "edit" 
    #       can :edit_profile, User
    #       cannot :update_profile, User
    #     elsif permission.subject_class == "Registration" && permission.action == "update" 
    #       cannot :edit_profile, User
    #       can :update_profile, User
    #     end
    #   end
    # end

    can :manage, Role do |role|
    	!Role.protected_roles.exists?(role.id)
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
