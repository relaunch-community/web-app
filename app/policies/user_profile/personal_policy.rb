class UserProfile::PersonalPolicy < ApplicationPolicy
  class Scope < Scope
    def initialize(user, record)
      @user = user
      @record = record
    end

    def resolve
      if user.admin?
        record.all
      else
        record.where(user: user)
      end
    end

    private

    attr_reader :user, :record
  end

  def index?
    false
  end

  def new?
    user == record.user
  end

  def create?
    user == record.user
  end

  def edit?
    user == record.user
  end

  def update?
    user == record.user
  end

  def destroy?
    false
  end

  def show?
    record.public? || user.admin? || (user == record.user)
  end
end
