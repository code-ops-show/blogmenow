# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

["Short Episodes", "Series", "Paid", "Free"].each do |c|
  Category.create(name: c)
end


1000.times do |i|
  Post.create(status: 1) do |p|
    p.title = "Example Post #{i}"
    p.body  = "Post Body #{i}"
    p.category = Category.all.sample
  end
end

["Ruby", "Rails", "Optimize", "Blah", "Yay"].each do |t|
  Tag.create(name: t)
end

Post.all.each do |p|
  tags = Tag.all.sample(3)
  p.tags = tags
  p.save
end