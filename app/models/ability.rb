class Ability
  include CanCan::Ability
  def initialize account
      account ||= Account.new
      if account.admin?
        can :manage, :all
      else
        can [:create, :update, :destroy], Comment do |comment|
          comment.account_id = account.id
        end
      end
  end
end
