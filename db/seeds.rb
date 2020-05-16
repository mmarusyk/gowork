# Create a main sample user.
User.create!(
  first_name: 'Admin',
  last_name: 'Admin',
  email: 'admin@e.e',
  city: 'Ukraine',
  description: 'I am ADministrator',
  password: '121212',
  password_confirmation: '121212',
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)
names = %w[Євген Адам Олександр Олексій Анатолій Андрій Антон Артем Артур Борис Вадим Валентин Валерій
  Василь Віталій Володимир Владислав Геннадій Георгій Григорій Данил Данило Денис Дмитро
  Євгеній Іван Ігор Йосип Кирил Костянтин Лев Леонід Максим Мирослав Михайло Назар
  Микита Микола Олег Павло Роман Руслан Сергій Станіслав Тарас Тимофій Федір
  Юрій Ярослав Богдан Болеслав Валерій Всеволод Віктор Ілля]
last_names = %w[Антоненко Василенко Васильчук Васильєв Гнатюк Дмитренко
  Захарчук Іванченко Микитюк Павлюк Панасюк Петренко Романченко
  Сергієнко Середа Таращук Боднаренко Броваренко Броварчук Кравченко
  Кравчук Крамаренко Крамарчук Мельниченко Мірошниченко Шевченко Шевчук
  Шинкаренко Пономаренко Пономарчук Лисенко]
# Generate a bunch of additional users.
20.times do |n|
  first_name = names.sample
  last_name = last_names.sample
  email = "example-#{n+1}@e.e"
  password = "password#{n+1}"
  cities = %w[Івано-Франкіськ Вінниця Дніпро Житомир Запоріжжя Київ Кропивницький Луцьк Львів Миколаїв Одеса Полтава Рівне Суми Тернопіль Ужгород Харків Херсон Хмельницький Черкаси Чернівці Черкаси]
  description = 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Molestiae sed perferendis libero ducimus optio ipsum. Consectetur, aspernatur? Ipsum quas, vitae recusandae, cupiditate, cum et voluptatum tenetur veniam nisi laboriosam dolore'
  User.create!(
    first_name: first_name,
    last_name: last_name,
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
categories = ['Справи по дому', 'Кур\'єрські послуги', 'Будівельні роботи', 'Ремонт техніки', 'Робота в інтернеті', 'Розробка', 'Реклама', 'Дизайн', 'Переклади', 'Фотозйомка', 'Організація свят', 'Авто', 'Навчання', 'Догляд за тваринами', 'Здоров\'я', 'Інші категорії']
16.times do |n|
  title = categories[n]
  description = 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Molestiae sed perferendis libero ducimus optio ipsum.'
  category = Category.create!(
    title: title,
    description: description
  )
  categories.push category.id
end

# Generate orders for a subset of users.
users = User.order(:created_at).take(6)
orders = []
2.times do
  title = Faker::Lorem.sentence(word_count: 2)
  description = Faker::Lorem.sentence(word_count: 150)
  skills = Faker::Job.key_skill
  city = Faker::Address.city
  duedate = Faker::Time.forward(days: 10)
  category_id = categories.sample
  price = Faker::Number.between(from: 100.0, to: 500.0).round(2)
  status = 'active'
  users.each { |user|
    order = user.orders.create!(
    title: title,
    description: description,
    skills: skills,
    city: city,
    duedate: duedate,
    category_id: category_id,
    price: price,
    status: status
    )
    orders.push order.id
  }
end

2.times do
  content = Faker::Lorem.sentence(word_count: 50)
  duedate = Faker::Time.forward(days: 10)
  order_id = orders.sample
  price = Faker::Number.between(from: 100.0, to: 500.0).round(2)
  users.each { |user| user.proposals.create!(
    content: content,
    duedate: duedate,
    order_id: order_id,
    price: price
    )
  }
end
