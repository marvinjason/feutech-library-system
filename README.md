
# Resources

## books
	id
	title
	publisher_id
	publication_address
	publication_year
	description
	edition
	series
	isbn
	call_number
	language
	page_count
	book_format
	cover
	total_count
	created_at
	updated_at

## authors
	id
	last_name
	first_name
	avatar
	description
	created_at
	updated_at

## authorships
	id
	book_id
	author_id
	created_at
	updated_at

## publishers
	id
	name
	created_at
	updated_at

## users
	id
	last_name
	first_name
	email
	password
	contact_number
	address
	role
	provider
	uid
	avatar
	created_at
	updated_at

## reservations
	id
	user_id
	book_id
	start
	end
	status [approved/rejected/pending]
	created_at
	updated_at

## reviews
	id
	book_id
	body
	rating
	user_id
	created_at
	updated_at

## comments
	id
	body
	user_id
	book_id
	comment_id
	created_at
	updated_at
