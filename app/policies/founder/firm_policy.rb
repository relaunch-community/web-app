class Founder::FirmPolicy < ApplicationPolicy
  class Scope < Scope
    def initialize(user, record)
      @user = user
      @record = record
    end

    def resolve
      if user.admin?
        record.all
      elsif user.present?
        record
          .founded_by(user.professional_profile.id)
          .or(
            Founder::Firm.publicly_or_internally_visible
          )
          .or(
            Founder::Firm.managed_by(user.professional_profile.id)
          )
      else
        record.publicly_visible
      end
    end

    private

    attr_reader :user, :record
  end

  def index?
    user.admin?
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
