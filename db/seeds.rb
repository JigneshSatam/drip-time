# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

e1 = Exporter.new(name: "abc", email: "abc@def.com", password: "abcdefg")
e1.save
e1.update(name: "abc-2")

e2 = Exporter.create(name: "dhawbdw", email: "dbawhdbjwa@def.com", password: "abcdefg")
e3 = Exporter.create(name: "lmn", email: "lmn@def.com", password: "abcdefghi")

# To get Exporters where 'name' changed from 'abc' to 'abc-2' and where archived before today
# should return an array consisting of 'e1'
Exporter.joins(archived: :modifications).where(modifications: {attribute_name: "name", from: "abc", to: "abc-2"})
# .where("archived_exporters.created_at < ?", Date.today.end_of_day)

i1 = Insurance.new(status: "inprogress", exporter_id: e2.id, grade: 10)
i1.save
i1.update(status: "completed")

i2 = Insurance.create(status: "inprogress", exporter_id: e3.id, grade: 9)

# To get Insurances where 'name' changed from 'inprogress' to 'completed'
# should return an array consisting of 'i1'
Insurance.joins(archived: :modifications).where(modifications: {attribute_name: "status", from: "inprogress", to: "completed"})


# To get Insurances where 'name' changed from 'inprogress' to 'completed'
# should return an array consisting of 'i1'
Insurance.joins(archived: :modifications).where(modifications: {attribute_name: "status", from: "inprogress", to: "completed"})

# To get Exporter where 'name' changed from 'inprogress' to 'completed'
# should return an array consisting of 'e1'
Exporter.joins(insurance: {archived: :modifications}).where(modifications: {attribute_name: "status", from: "inprogress", to: "completed"})
