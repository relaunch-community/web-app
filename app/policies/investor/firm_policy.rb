class Investor::FirmPolicy < ApplicationPolicy
  class Scope < Scope
    def initialize(user, record)
      @user = user
      @record = record
    end

    def resolve
      record.all
    end

    private

    attr_reader :user, :record
  end

  def index?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def show?
    true
  end

  def current_user_investor_role_firms
    record.joins(:investor_firm_roles).where(investor_firm_roles: { user: user })
  end
end
