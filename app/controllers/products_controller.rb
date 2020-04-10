class ProductsController < ApplicationController
  before_action :set_product, except: [:index, :new, :create]

  def show
  end

  def new
    @product = Product.new
    @product.images.new
  end

  # def create
  #   @product = Product.new(product_params)
  #   if @product.save
  #     redirect_to root_path
  #   else 
  #     render :new
  #   end
  # end
  def create
    @product = Product.new(product_params)
    unless @product.valid?
      flash.now[:alert] = @product.errors.full_messages
      @product.images.new
      render :new and return
    end
    if @product.save
      redirect_to root_path
    else
      @product.images.new
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end
  

  def product_params
    params.require(:product).permit(:name, :price, :description, :brand, :status, :shipping_cost, :shipping_days, images_attributes: [:src])
  end

  def set_product
    @product = Product.find(params[:id])
  end

end
