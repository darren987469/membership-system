User.roles.each_key do |role|
  email = "#{role}@gmail.com"
  password = '666666'
  User.create(email: email, password: password, role: role)
end

(1..20).to_a.each do |n|
  email = "normal#{n}@gmail.com"
  User.create(email: email, password: '666666')

  name = "product#{n}"
  price = n * 10
  product = Product.create(name: name, price: price)
  product.images.attach(io: File.open('spec/fixtures/thumbs-up.png'), filename: 'thumbs-up.png')
end
