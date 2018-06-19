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
    description: Faker::Lorem.paragraph(15),
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

User.create(
  email: 'test@gmail.com',
  password: '123456',
  last_name: 'Doe',
  first_name: 'John',
  contact_number: '09123456789',
  address: 'Philippines',
  remote_avatar_url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFqLwXLSt7nY_iW0vRguTgVIH1gjwuhx28PjI_Dc964oTRx0No'
)

User.create(
  email: 'librarian@gmail.com',
  password: '123456',
  last_name: 'Gabarda',
  first_name: 'Lorenzo',
  contact_number: '09123456789',
  address: 'Philippines',
  remote_avatar_url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFqLwXLSt7nY_iW0vRguTgVIH1gjwuhx28PjI_Dc964oTRx0No',
  role: 'librarian'
)

User.create(
  email: 'admin@gmail.com',
  password: '123456',
  last_name: 'Ancheta',
  first_name: 'Michael',
  contact_number: '09123456789',
  address: 'Philippines',
  remote_avatar_url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFqLwXLSt7nY_iW0vRguTgVIH1gjwuhx28PjI_Dc964oTRx0No',
  role: 'admin'
)

Book.all.each do |book|
  3.times do
    Review.create(
      book: book,
      user: User.first,
      rating: (1..5).to_a.sample,
      body: Faker::Lorem.paragraph(10)
    )

    comment = Comment.create(
      book: book,
      user: User.first,
      body: Faker::Lorem.sentence(10)
    )

    if [true, false].sample
      (1..3).to_a.sample.times do
        Comment.create(
          book: book,
          user: User.first,
          body: Faker::Lorem.sentence(10),
          comment: comment
        )
      end
    end
  end
end
