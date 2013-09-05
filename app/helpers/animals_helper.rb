module AnimalsHelper
  include UsersHelper
  def add_matingdate(animal)
  end

  def current_user_has_owner
    unless user_has_owner?(current_user)
      redirect_to no_owner_url, notice: "Please assosiate a owner to this user."
    end
  end

  def get_animals_for_pagination(year)
    start_year = Date.parse('1.1.1970')
    end_year = Date.today
    if year.present? then
      start_year = Date.parse('1.1.' + year)
      end_year = Date.parse('31.12.' + year)
    end

    current_user.owners.first.animals.where("birth_date >= ? and birth_date <= ?",
           start_year,end_year).paginate(page: params[:page])
  end

end
