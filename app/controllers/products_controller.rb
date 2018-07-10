class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.includes(:product_scrapes).all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product_details = @product.product_scrapes.last
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # # GET /products/1/edit
  # def edit
  # end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    result = SaveProduct.new(@product).call
    respond_to do |format|
      if result.ok?
        format.html { redirect_to products_url, notice: 'Product data successfully imported.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, notice: 'Unable to add amazon product.' }
        format.json { render json: result.error, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      result = SaveProduct.new(@product).call
      if result.ok?
        format.html { redirect_to products_url, notice: 'Product details successfully fetched again from Amazon.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { redirect_to products_url, notice: 'Unable to fetch product details from Amazon. Please try again.' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:asin)
    end
end
