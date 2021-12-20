class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]

  # GET /books or /books.json
  def index
      @books = Book.all
    if params[:pricesortasc]
      @books = @books.order(:price)          # sort by price ascending
    end
    if params[:pricesortdesc]
      @books = @books.order(price: :desc)    # sort by price descending
    end
    if params[:freebooks]
      @books = @books.where("price = 0")     # select free books
    end
    if params[:tag2]
      @books = Book.joins(:tag).where(:tags => {:tag2 => 'true'})   # list books with tag2 checked
    end
    if params[:tag1]
      @books = Book.joins(:tag).where(:tags => {:tag1 => 'true'})   # list books with tag1 checked
    end
    if params[:tag3]
        @books = Book.joins(:tag).where(:tags => {:tag3 => 'true'})  # list books with tag3 checked
    end
    if params[:tag1tag2]
        @books = Book.joins(:tag).where(:tags => {:tag1 => 'true', :tag2 => 'true'})  # list books with tag1 and tag2 checked
    end
    if params[:tag1tag3]
        @books = Book.joins(:tag).where(:tags => {:tag1 => 'true', :tag3 => 'true'})  # list books with tag1 and tag3 checked
    end
    if params[:tag2tag3]
      @books = Book.joins(:tag).where(:tags => {:tag2 => 'true', :tag3 => 'true'})    # list books with tag2 and tag3 checked
    end
    if params[:tag2tag3pr56]
      @books = Book.joins(:tag).where(:tags => {:tag2 => 'true', :tag3 => 'true'}, :books => { :price => '56'})      # list books with tag2 and tag3 checked and price = 56
    end
    if params[:tag2tag3pr0]
      @books = Book.joins(:tag).where(:tags => {:tag2 => 'true', :tag3 => 'true'}, :books => { :price => '0'})       # list books with tag2 and tag3 checked and price = 0
    end
    if params[:tag2tag3prg0]
      @books = Book.joins(:tag).where([ 'tags.tag2 = true AND  tags.tag3 = true AND books.price >=  0'])             # list books with tag2 and tag3 checked and price >= 0
    end
    if params[:tag1tag2prg0]
      @books = Book.joins(:tag).where([ 'tags.tag1 = true AND  tags.tag2 = true AND books.price >=  0'])             # list books with tag2 and tag3 checked and price >= 0
    end
    
    
    # render json: @books
    
    
    ###############################                                                  ################################
    ###############################  QUERIES TO BE IMPLEMENTED FROM FROTNEND SIDE    ################################
    ###############################                                                  ################################
    # @books = @books.sort_by &:created_at                                                                           # sort by created at
    # @books = @books.order(:price)                                                                                  # sort by price ascending
    # @books = @books.order(price: :desc)                                                                            # sort by price descending
    # @books = @books.where("price = 0")                                                                             # select free books
    # @books = @books.where("id = 1")                                                                                # select books through id
    # @books = Book.joins(:tag).where(:tags => {:tag2 => 'true'})                                                    # list books with tag2 checked
    # @books = Book.joins(:tag).where(:tags => {:tag1 => 'true'})                                                    # list books with tag1 checked
    # @books = Book.joins(:tag).where(:tags => {:tag3 => 'true'})                                                    # list books with tag3 checked
    # @books = Book.joins(:tag).where(:tags => {:tag1 => 'true', :tag2 => 'true'})                                   # list books with tag1 and tag2 checked
    # @books = Book.joins(:tag).where(:tags => {:tag1 => 'true', :tag3 => 'true'})                                   # list books with tag1 and tag3 checked
    # @books = Book.joins(:tag).where(:tags => {:tag2 => 'true', :tag3 => 'true'})                                   # list books with tag2 and tag3 checked
    # @books = Book.joins(:tag).where(:tags => {:tag2 => 'true', :tag3 => 'true'}, :books => { :price => '56'})      # list books with tag2 and tag3 checked and price = 56
    # @books = Book.joins(:tag).where(:tags => {:tag2 => 'true', :tag3 => 'true'}, :books => { :price => '0'})       # list books with tag2 and tag3 checked and price = 0
    # @books = Book.joins(:tag).where([ 'tags.tag2 = true AND  tags.tag3 = true AND books.price >=  0'])             # list books with tag2 and tag3 checked and price >= 0
  end


  
    

  # GET /books/1 or /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :description, :price)
    end
end
