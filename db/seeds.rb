# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: 'admin@admin.com',
  password: 'adminadmin'
  )

Tag.create([
  { name: '犬' },
  { name: '猫' },
  { name: '鳥' },
  { name: '爬虫類' },
  { name: '昆虫' },
  { name: 'その他' }
])