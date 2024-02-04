require 'faker'

Faker::Config.locale = 'pt-BR'

if UserType.count.zero?
    UserType.create(id: 1, name_type: "Administrador")
    UserType.create(id: 2, name_type: "Normal")
end
if User.count.zero?
    User.create(username: "admin", password: "admin123", user_type_id: UserType.first.id)
    User.create(username: "user", password: "112233", user_type_id: UserType.last.id)
end

if Product.count.zero?
    num_products = 10
  
    num_products.times do
      Product.create(
        name: Faker::Commerce.product_name,
        description: Faker::Lorem.sentence,
        price: Faker::Commerce.price(range: 10.0..100.0, as_string: false)
      )
    end
end