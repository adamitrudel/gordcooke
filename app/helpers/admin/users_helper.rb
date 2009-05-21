module Admin::UsersHelper
  def roles(user)
    roles = []
    roles << 'Administrator' if user.admin?
    roles << 'Regular' if user.developer?
    roles.join(', ')
  end
end
