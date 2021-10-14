class PetPolicy < ApplicationPolicy


  def show?
    true  # Anyone can view a flat
  end

  def create?
    true
  end

  def edit?
    record.user_id == user.id
  end

  def update?
    record.user_id == user.id
  end

  def destroy?
    record.user_id == user.id
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
