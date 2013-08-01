namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    clear_all_data
    setup_users_and_owners
    make_animals
  end
end

def clear_all_data
  Owner.delete_all
  User.delete_all
  Animal.delete_all
  Note.delete_all
  Mating.delete_all
  Animalrelation.delete_all
end

def setup_users_and_owners
  make_owners
  make_users
  owner1 = Owner.first
  user1 = User.first
  owner1.users << user1
  owner1.save
end
def make_owners
  Owner.create( name: "Owner 1",
                email: "example@mail.com",
                pnum: "02011011223")

  Owner.create( name: "Owner 2",
                email: "example2@mail.com",
                pnum: "01011011413")
end

def make_users
  User.create( name: "Havard Korsvoll",
               email: "korsvoll@gmail.com",
               password: "passord",
               password_confirmation: "passord" )
end

def make_animals
  owner1 = Owner.first
  #owners.each { |owner|
  30.times do |n|
    owner1.animals.create!(
      id_tag: 80100 + n,
      name: "Sau #{n}",
      birth_date: Date.parse("2008-04-20") + rand(20).days,
      sex: "female"
    )
    owner1.animals.create!(
        id_tag: 90100 + n,
        name: "Sau #{n}",
        birth_date: Date.parse("2009-04-20") + rand(20).days,
        sex: "female"
    )
  end
  animals = owner1.animals.where(
      "birth_date >= :low_date and birth_date < :high_date",
      {low_date: Date.parse("2008-01-01"), high_date: Date.parse("2009-01-01")}
  )
  animals.each_with_index do |a, i|
    a.children.create(
        id_tag: 100 + 2 * i,
        name: "Sau #{2 * i}",
        birth_date: Date.parse("2010-04-20") + rand(20).days,
        sex: "female"
    )
    a.children.create(
        id_tag: 101 + 2 * i,
        name: "Sau #{2 * i + 1}",
        birth_date: Date.parse("2010-04-20") + rand(20).days,
        sex: "female"
    )
  end
  #}
end