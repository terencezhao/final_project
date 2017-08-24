class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
    @products = Product.all
    render("reviews/index.html.erb")
  end

  def show
    @review = Review.find(params[:id])

    render("reviews/show.html.erb")
  end
  
  def show_for_product
    @reviews = Review.all
    @product = Product.find(params[:id])
    @reviews_for_product = @reviews.select{ |review| review[:product_id] == @product.id }
    @quality_average = @reviews_for_product.map{ |review| review.quality }.inject{ |sum, q| sum + q}.to_f/@reviews_for_product.size
    @value_average = @reviews_for_product.map{ |review| review.value }.inject{ |sum, v| sum + v}.to_f/@reviews_for_product.size
    @style_average = @reviews_for_product.map{ |review| review.style }.inject{ |sum, s| sum + s}.to_f/@reviews_for_product.size
    @utility_average = @reviews_for_product.map{ |review| review.utility }.inject{ |sum, u| sum + u}.to_f/@reviews_for_product.size
    @enjoyment_average = @reviews_for_product.map{ |review| review.enjoyment }.inject{ |sum, e| sum + e}.to_f/@reviews_for_product.size
    @recommendation_average = @reviews_for_product.select { |review| review.recommend == true }.size.to_f/@reviews_for_product.size.to_f
    render("reviews/for_product.html.erb")
  end
  
  def show_for_user
    @reviews = Review.all
    @user = User.find(params[:id])
    @reviews_for_user = @reviews.select{ |review| review[:user_id] == @user.id }
    
    render("reviews/for_user.html.erb")
  end

  def new
    @review = Review.new

    render("reviews/new.html.erb")
  end
  
  def new_review_for_product
    @product = Product.find(params[:id])
    render("reviews/new_review_for_product.html.erb")
  end

  def create
    @review = Review.new

    @review.user_id = current_user.id
    @review.product_id = params[:product_id]
    @review.quality = params[:quality]
    @review.value = params[:value]
    @review.style = params[:style]
    @review.utility = params[:utility]
    @review.enjoyment = params[:enjoyment]
    @review.recommend = params[:recommend]

    save_status = @review.save

    if save_status == true
      redirect_to("/products", :notice => "Review created successfully.")
    else
      render("reviews/new.html.erb")
    end
  end

  def edit
    @review = Review.find(params[:id])

    render("reviews/edit.html.erb")
  end

  def update
    @review = Review.find(params[:id])

    @review.user_id = params[:user_id]
    @review.product_id = params[:product_id]
    @review.quality = params[:quality]
    @review.value = params[:value]
    @review.style = params[:style]
    @review.utility = params[:utility]
    @review.enjoyment = params[:enjoyment]
    @review.recommend = params[:recommend]

    save_status = @review.save

    if save_status == true
      redirect_to("/reviews/for_user/" + current_user.id.to_s, :notice => "Review updated successfully.")
    else
      render("reviews/edit.html.erb")
    end
  end

  def destroy
    @review = Review.find(params[:id])

    @review.destroy

    if URI(request.referer).path == "/reviews/#{@review.id}"
      redirect_to("/", :notice => "Review deleted.")
    else
      redirect_to(:back, :notice => "Review deleted.")
    end
  end
end
