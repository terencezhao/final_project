class CategoriesController < ApplicationController
  def index
    @categories = Category.all

    render("categories/index.html.erb")
  end

  def show
    @category = Category.find(params[:id])
    
    @products_sorted_by_review = @category.products.sort_by { 
      |product| product.reviews.map { 
        |review| (review.quality + review.value + review.style + review.utility + review.enjoyment)/5.0
      }
    }.reverse!
     
    @products_sorted_by_recommendation = @category.products.sort_by {
      |product| product.reviews.select {
        |review| review.recommend 
      }.size
    }.reverse!


    render("categories/show.html.erb")
  end

  def new
    @category = Category.new

    render("categories/new.html.erb")
  end

  def create
    @category = Category.new

    @category.name = params[:name]

    save_status = @category.save

    if save_status == true
      redirect_to("/products/new", :notice => "Category created successfully.")
    else
      render("categories/new.html.erb")
    end
  end

  def edit
    @category = Category.find(params[:id])

    render("categories/edit.html.erb")
  end

  def update
    @category = Category.find(params[:id])

    @category.name = params[:name]

    save_status = @category.save

    if save_status == true
      redirect_to("/categories", :notice => "Category updated successfully.")
    else
      render("categories/edit.html.erb")
    end
  end

  def destroy
    @category = Category.find(params[:id])

    @category.destroy

    if URI(request.referer).path == "/categories/#{@category.id}"
      redirect_to("/", :notice => "Category deleted.")
    else
      redirect_to(:back, :notice => "Category deleted.")
    end
  end
end
