class Founder::FirmRolePolicy < ApplicationPolicy
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
          .where(professional_profile: user.professional_profile)
          .or(
            Founder::FirmRole.publicly_or_internally_visible
          )
      else
        record.publicly_visible
      end
    end

    private

    attr_reader :user, :record
  end

  def index?
    record.professional_profile
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
