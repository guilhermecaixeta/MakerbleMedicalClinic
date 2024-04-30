# typed: true
# string_frozen_literal: true

class UserPolicy < ApplicationPolicy
  def initialize(user, record)
    super user, record
    get_admin_role
  end

  def can_read?
    has_read_permission?
  end

  def can_read_and_write?
    has_read_and_write_permission?
  end

  def has_read_permission?
    User.joins(roles: :permissions).where(
      "users.id = :id AND (roles.name = :admin_name OR permissions.scope = :controller_read OR permissions.scope = :controller_write)",
      { id: user.id, admin_name: @admin_role, controller_read: "#{record}:read", controller_write: "#{record}:write" }
    ).exists?
  end

  def has_read_and_write_permission?
    User.joins(roles: :permissions).where(
      "users.id = :id AND (roles.name = :admin_name OR permissions.scope = :controller_write)",
      { id: user.id, admin_name: @admin_role, controller_write: "#{record}:write" }
    ).exists?
  end

  def get_admin_role
    @admin_role = "Administrator"
  end
end
