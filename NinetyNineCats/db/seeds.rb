# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cat.delete_all

a1 = Cat.create(birth_date: "2015/01/20", color: :green, name: 'Clarisse', sex: 'M')
a2 = Cat.create(birth_date: "2013/02/20", color: :tabby, name: 'Florence', sex: 'F')
a3 = Cat.create(birth_date: "2012/03/20", color: :calico, name: 'Mildred', sex: 'F')
a4 = Cat.create(birth_date: "2011/04/20", color: :orange, name: 'Dorothy', sex: 'M')

CatRentalRequest.delete_all

b1 = CatRentalRequest.create(cat_id: a1.id, start_date: "2017/04/30", end_date: "2017/05/30", status: "Approved")
b2 = CatRentalRequest.create(cat_id: a1.id, start_date: "2017/02/15", end_date: "2017/03/15", status: "Approved")
