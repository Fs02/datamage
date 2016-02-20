# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Seed Category
level_0 = Category.create(name: 'Fashion')
  level_1 = Category.create(name: 'Watch', parent_id: level_0.id.to_s)
    level_2 = Category.create(name: 'Analog', parent_id: level_1.id.to_s)
    level_2 = Category.create(name: 'Digital', parent_id: level_1.id.to_s)
    level_2 = Category.create(name: 'LED', parent_id: level_1.id.to_s)
    level_2 = Category.create(name: 'Others', parent_id: level_1.id.to_s)
  level_1 = Category.create(name: 'Shoes', parent_id: level_0.id.to_s)
    level_2 = Category.create(name: 'Boot', parent_id: level_1.id.to_s)
    level_2 = Category.create(name: 'Casual', parent_id: level_1.id.to_s)
    level_2 = Category.create(name: 'Crocs', parent_id: level_1.id.to_s)
    level_2 = Category.create(name: 'Flat Shoes', parent_id: level_1.id.to_s)
    level_2 = Category.create(name: 'Pantofel', parent_id: level_1.id.to_s)
    level_2 = Category.create(name: 'Sandal & Flip Flop', parent_id: level_1.id.to_s)
    level_2 = Category.create(name: 'Kets', parent_id: level_1.id.to_s)
    level_2 = Category.create(name: 'Others', parent_id: level_1.id.to_s)
