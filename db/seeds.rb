Account.create!(fullname: "Admin",address: "Ninh Binh", phone: "123456789", email: "admin@gmail.com", password: "1234567",
  password_confirmation: "1234567", account_type: 1)
Account.create!(fullname: "Minh Hang",address: "Ninh Binh", phone: "123456789", email: "user1@gmail.com", password: "1234567",
  password_confirmation: "1234567", account_type: 0)
Account.create!(fullname: "Hoang Anh",address: "Ninh Binh", phone: "123456789", email: "user2@gmail.com", password: "1234567",
  password_confirmation: "1234567", account_type: 0)
Category.create!(name: "Samsung")
Category.create!(name: "Nokia")
Category.create!(name: "HTC")
Category.create!(name: "Iphone")
Category.create!(name: "Sony")
Category.create!(name: "OOPO")
Manufacturer.create!(name: "Samsung")
Manufacturer.create!(name: "Nokia")
Manufacturer.create!(name: "HTC")
Manufacturer.create!(name: "Iphone")
Manufacturer.create!(name: "Sony")
Manufacturer.create!(name: "OOPO")
