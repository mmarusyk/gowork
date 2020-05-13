# Create a main sample user.
User.create!(
  first_name: 'User',
  last_name: 'Last',
  email: 'example@e.e',
  city: 'Kyiv',
  description: 'Description. I like Rails',
  password: '111111',
  password_confirmation:'111111')

# Generate a bunch of additional users.
99.times do |n| name = Faker::Name.name
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
    password_confirmation: password
  )
end
