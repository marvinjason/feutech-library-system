5.times do
  Publisher.create(
    name: Faker::Book.publisher
  )
end

5.times do
  Author.create(
    last_name: Faker::Name.last_name,
    first_name: Faker::Name.first_name,
    description: Faker::Lorem.paragraph,
    remote_avatar_url: 'https://avatars3.githubusercontent.com/u/22198984?s=460&v=4'
  )
end

EDITIONS = ['Book Club', 'First', 'Second', 'Third'].freeze

25.times do
  book = Book.create(
    title: Faker::Book.title,
    publisher: Publisher.all.sample,
    publication_address: Faker::Address.country,
    publication_year: (1980..2018).to_a.sample,
    description: Faker::Lorem.paragraph,
    edition: EDITIONS.sample,
    isbn: '978-3-16-148410-0',
    call_number: 'PR 8923 W6 L36 1990 c.3',
    language: 'English',
    page_count: 245,
    book_format: 'Paperback',
    remote_cover_url: 'https://images.gr-assets.com/books/1420911526l/3685.jpg',
    total_count: 5
  )

  (1..2).to_a.sample.times do
    book.authors << Author.all.sample
  end
end
