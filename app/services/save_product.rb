class SaveProduct
  attr_reader :asin, :product
  attr_accessor :data

  def initialize(product)
    @product = product
    @asin = product.asin
  end

  def call
  result = GitHub::Result.new {
      GitHub::Result.new { @data = Amazoned::Client.new(asin).call }
    }.then { |value|
      GitHub::Result.new {
        save_product! }
    }.then { |value|
      GitHub::Result.new {
        save_product_scrape!(@data)
      }
    }
  end

  def save_product!
    product = Product.find_or_initialize_by(asin: asin)
    product.save!
  end

  def save_product_scrape!(data)
    product = Product.find_by(asin: asin)
    product.product_scrapes.create!(
      data: data,
      product_dimensions: data[:package_dimensions],
      rank: data[:rank],
      category: data[:category]
    )
  end
end