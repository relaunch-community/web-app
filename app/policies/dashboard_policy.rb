class DashboardPolicy
  attr_reader :user

  def initialize(user, _record)
    @user = user
  end

  def show?
    user&.persisted?
  end

  def coming_soon?
    user&.persisted?
  end
end
