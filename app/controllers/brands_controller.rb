class BrandsController < ApplicationController
  def index
    @brands = Brand.all

    render("brands/index.html.erb")
  end

  def show
    @brand = Brand.find(params[:id])
    
    @products_sorted_by_review = @brand.products.sort_by { 
      |product| product.reviews.map { 
        |review| (review.quality + review.value + review.style + review.utility + review.enjoyment)/5.0
      }
    }.reverse!
     
    @products_sorted_by_recommendation = @brand.products.sort_by {
      |product| product.reviews.select {
        |review| review.recommend 
      }.size
    }.reverse!

    render("brands/show.html.erb")
  end

  def new
    @brand = Brand.new

    render("brands/new.html.erb")
  end

  def create
    @brand = Brand.new

    @brand.name = params[:name]
    @brand.logo = params[:logo]

    save_status = @brand.save

    if save_status == true
      redirect_to("/products/new", :notice => "Brand created successfully.")
    else
      render("brands/new.html.erb")
    end
  end

  def edit
    @brand = Brand.find(params[:id])

    render("brands/edit.html.erb")
  end

  def update
    @brand = Brand.find(params[:id])

    @brand.name = params[:name]
    @brand.logo = params[:logo]

    save_status = @brand.save

    if save_status == true
      redirect_to("/brands", :notice => "Brand updated successfully.")
    else
      render("brands/edit.html.erb")
    end
  end

  def destroy
    @brand = Brand.find(params[:id])

    @brand.destroy

    if URI(request.referer).path == "/brands/#{@brand.id}"
      redirect_to("/", :notice => "Brand deleted.")
    else
      redirect_to(:back, :notice => "Brand deleted.")
    end
  end
end
