module UsersHelper
  def user_has_owner?(user)
    !user.owner.nil?
  end
end