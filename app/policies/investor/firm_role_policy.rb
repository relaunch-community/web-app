class Investor::FirmRolePolicy < ApplicationPolicy
  class Scope < Scope
    def initialize(user, record)
      @user = user
      @record = record
    end

    def resolve
      if user.admin?
        record.all
      else
        record.where(professional_profile: user.professional_profile)
      end
    end

    private

    attr_reader :user, :record
  end

  def index?
    true
  end

  def new?
    user.professional_profile == record.professional_profile
  end

  def create?
    user.professional_profile == record.professional_profile
  end

  def edit?
    user.professional_profile == record.professional_profile
  end

  def update?
    user.professional_profile == record.professional_profile
  end

  def destroy?
    user.professional_profile == record.professional_profile
  end

  def show?
    true
  end
end
