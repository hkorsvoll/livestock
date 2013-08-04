module OwnersHelper
  include UsersHelper

  def current_user_has_owner
    unless user_has_owner?(current_user)
      flash.now[:notice] = 'No owner is assosiated with this user'
    end

  end
end
