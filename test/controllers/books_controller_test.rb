require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:one)
  end

  test "should get index" do
    get books_url
    assert_response :success
  end

  test "should get new" do
    get new_book_url
    assert_response :success
  end

  test "should create book" do
    assert_difference('Book.count') do
      post books_url, params: { book: { book_format: @book.book_format, call_number: @book.call_number, cover: @book.cover, description: @book.description, edition: @book.edition, isbn: @book.isbn, language: @book.language, page_count: @book.page_count, publication_address: @book.publication_address, publication_year: @book.publication_year, publisher_id: @book.publisher_id, series: @book.series, title: @book.title, total_count: @book.total_count } }
    end

    assert_redirected_to book_url(Book.last)
  end

  test "should show book" do
    get book_url(@book)
    assert_response :success
  end

  test "should get edit" do
    get edit_book_url(@book)
    assert_response :success
  end

  test "should update book" do
    patch book_url(@book), params: { book: { book_format: @book.book_format, call_number: @book.call_number, cover: @book.cover, description: @book.description, edition: @book.edition, isbn: @book.isbn, language: @book.language, page_count: @book.page_count, publication_address: @book.publication_address, publication_year: @book.publication_year, publisher_id: @book.publisher_id, series: @book.series, title: @book.title, total_count: @book.total_count } }
    assert_redirected_to book_url(@book)
  end

  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete book_url(@book)
    end

    assert_redirected_to books_url
  end
end
