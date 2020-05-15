# Create a main sample user.
User.create!(
  first_name: 'User',
  last_name: 'Last',
  email: 'example@e.e',
  city: 'Kyiv',
  description: 'Description. I like Rails',
  password: '111111',
  password_confirmation: '111111',
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)

# Generate a bunch of additional users.
10.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@e.e"
  password = "password"
  cities = %w[Івано-Франкіськ Вінниця Дніпро Житомир Запоріжжя Київ Кропивницький Луцьк Львів Миколаїв Одеса Полтава Рівне Суми Тернопіль Ужгород Харків Херсон Хмельницький Черкаси Чернівці Черкаси]
  description = 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Molestiae sed perferendis libero ducimus optio ipsum. Consectetur, aspernatur? Ipsum quas, vitae recusandae, cupiditate, cum et voluptatum tenetur veniam nisi laboriosam dolore'
  User.create!(
    first_name: name,
    last_name: "#{name}+ich",
    email: email,
    city: cities.sample,
    description: description,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now
  )
end

# Generate categories.
categories = []
20.times do
  title = Faker::Job.field
  description = 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Molestiae sed perferendis libero ducimus optio ipsum. Consectetur, aspernatur? Ipsum quas, vitae recusandae, cupiditate, cum et voluptatum tenetur veniam nisi laboriosam dolore'
  category = Category.create!(
    title: title,
    description: description
  )
  categories.push category.id
end

# Generate orders for a subset of users.
users = User.order(:created_at).take(6)

2.times do
  title = Faker::Lorem.sentence(word_count: 4)
  description = Faker::Lorem.sentence(word_count: 150)
  skills = Faker::Job.key_skill
  city = Faker::Address.city
  duedate = Faker::Time.forward(days: 30)
  category_id = categories.sample
  price = Faker::Number.between(from: 100.0, to: 10000.0).round(2)
  users.each { |user| user.orders.create!(
    title: title,
    description: description,
    skills: skills,
    city: city,
    duedate: duedate,
    category_id: category_id,
    price: price
    )
  }
end
