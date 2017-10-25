# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

class Seed
  def self.run
    new.run
  end

  def run
    generate_users
    generate_items
    generate_categories
    generate_orders
  end



  def generate_users
    50.times do |i|
      user = User.create!(
          name: Faker::Name.name,
          email: Faker::Internet.email,
          password: Faker::Pokemon.name
      )
      puts "User #{i}: #{user.name} - #{user.email} created!"
    end
  end

  def generate_items
    500.times do |i|
      item = Product.create!(
          name: Faker::Commerce.product_name,
          description: Faker::Lorem.paragraph,
          price: Faker::Commerce.price
      )
      puts "Item #{i}: #{item.name} created!"
    end
  end

  def generate_categories
    50.times do |i|
      category = Category.create!(
          name: Faker::Commerce.department,
          description: Faker::Lorem.paragraph,
      )
      puts "Category #{i}: #{category.name} created!"
      add_items_to_category(category)

    end
  end

  def generate_orders
    offsetable_amount = User.count - 1
    100.times do |i|
      user  = User.offset(rand(0..offsetable_amount)).limit(1).first
      stat = ["waiting for delivery", "on its way", "delivered"].sample
      order = Order.create!(
          user_id: user.id,
          status: stat
      )
      add_items(order)
      puts "Order #{i}: Order for #{user.name} created with status #{stat}!"
    end
  end

  private

  def add_items(order)
    order.amount = 9
    offsetable_amount = Product.count - 1
    10.times do |i|
      item = Product.offset(rand(0..offsetable_amount)).limit(1).first
      order.products << item
      order.amount = order.amount + 1
      # order.attributes = {:amount => 0.0}
      # order.save
      #order.amount = order.amount + item.price.to_f
      puts "#{i}: Added item #{item.name} to order #{order.id}."
    end
  end

  def add_items_to_category(category)
    offsetable_amount = Product.count - 1
    10.times do |i|
      item = Product.offset(rand(0..offsetable_amount)).limit(1).first
      category.products << item
      puts "#{i}: Added item #{item.name} to order #{category.id}."
    end
  end
end

Seed.run

