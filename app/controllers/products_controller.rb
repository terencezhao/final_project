class ProductsController < ApplicationController
  def index
    @products = Product.all
    @sort_by = params[:sort_by]
    @products_sorted_by_name = @products.sort_by { |product| product.name.downcase }
    @products_sorted_by_brand = @products.sort_by { |product| product.brand.name.downcase }
    @products_sorted_by_category = @products.sort_by { |product| product.category.name.downcase }
    @products_sorted_by_price = @products.sort_by { |product| product.price }
    @products_sorted_by_review = @products.sort_by { |product| product.reviews.map { |review| (review.quality + review.value + review.style + review.utility + review.enjoyment)/5.0 }.inject(0){|sum,x| sum+x}}.reverse!
    @products_sorted_by_recommendation = @products.sort_by { |product| product.reviews.select { |review| review.recommend }.size }.reverse!

    render("products/index.html.erb")
  end

  def show
    @product = Product.find(params[:id])

    render("products/show.html.erb")
  end

  def new
    @product = Product.new

    render("products/new.html.erb")
  end

  def create
    @product = Product.new

    @product.category_id = params[:category_id]
    @product.brand_id = params[:brand_id]
    @product.price = params[:price]
    @product.image_url = params[:image_url]
    @product.details = params[:details]
    @product.name = params[:name]

    save_status = @product.save

    if save_status == true
      redirect_to("/products", :notice => "Product created successfully.")
    else
      render("products/new.html.erb")
    end
  end

  def edit
    @product = Product.find(params[:id])

    render("products/edit.html.erb")
  end

  def update
    @product = Product.find(params[:id])

    @product.category_id = params[:category_id]
    @product.brand_id = params[:brand_id]
    @product.price = params[:price]
    @product.image_url = params[:image_url]
    @product.details = params[:details]
    @product.name = params[:name]

    save_status = @product.save

    if save_status == true
      redirect_to("/products", :notice => "Product updated successfully.")
    else
      render("products/edit.html.erb")
    end
  end

  def destroy
    @product = Product.find(params[:id])

    @product.destroy

    if URI(request.referer).path == "/products/#{@product.id}"
      redirect_to("/", :notice => "Product deleted.")
    else
      redirect_to(:back, :notice => "Product deleted.")
    end
  end
end
