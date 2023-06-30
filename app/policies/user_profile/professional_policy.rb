class UserProfile::ProfessionalPolicy < ApplicationPolicy
  class Scope < Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end

    private

    attr_reader :user, :scope
  end

  def show?
    true
  end
end
