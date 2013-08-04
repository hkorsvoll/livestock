module AnimalsHelper
  include UsersHelper
  def add_matingdate(animal)
  end

  def current_user_has_owner
    unless user_has_owner?(current_user)
      redirect_to no_owner_url, notice: "Please assosiate a owner to this user."
    end
  end

end
