class BooksController < ApplicationController
  before_action :set_book, only: [:show, :update]

  # GET /books
  # GET /books.json
  def index

    @books = Book.all.sample(4)
    render json: @books
  end

  # GET /books/1
  # GET /books/1.json
  def show
    render json: @book
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    if @book.save
      render json: @book, status: :created, location: @book
    else
      # render json: @book.errors, status: :unprocessable_entity
    end
  end

  private

    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.permit(:title, :thumbnail, :google_id)
    end
end


