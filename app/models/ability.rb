class Ability
  include CanCan::Ability

  def initialize(user)
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

    user ||= User.new # guest user (not logged in)

    can :read, :all
    can :create, Feedback
    can :manage, User, :id => user.id
    can :manage, Collection, :owner_id => user.id
    can :read, Collection, :is_private => false

    if user.admin?
      # non-REST-ful actions in the administrator controller
      can :index, :administrator
      can :change_admin, :administrator
      can :change_editor, :administrator
      can :change_basic, :administrator

      can :update, User

      # TODO this should be locked down much further since :manage is a
      # catch-all and could lead to security regressions
      can :manage, [CaseStudy, Characteristic, CharacteristicGroup, Citation,
                    Company, Contact, DesignMethod, MethodCaseStudy,
                    MethodCategory, MethodCharacteristic, MethodCitation, Tag]
      can :manage, Collection, :is_private => false
    elsif user.editor?
      can [:create, :update], [DesignMethod, CaseStudy]
      can :manage, MethodCharacteristic
    end

  end
end
