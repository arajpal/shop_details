# frozen_string_literal: true

require 'yaml'

class Product
  @@product = {}
  attr_accessor :product
  ATTR_PRODUCT = [:name, :seller, :price, :category]

  ATTR_PRODUCT.each do |field|
    attr_accessor field
  end

  def self.import_data_source
    product_details = YAML.load_file 'products_data.yaml'
    product_details.each do |product_detail|
      @@product[product_detail[:seller]] ||= []
      @@product[product_detail[:seller]] << self.new(product_detail)
    end
  end

  def initialize(product_detail)
    self.name = product_detail[:name]
    self.seller = product_detail[:seller]
    self.price = product_detail[:price]
    self.category = product_detail[:category]
  end

  def self.all
    @@product
  end

  define_method 'details' do
    product_detail = []
    ATTR_PRODUCT.each do |field|
      product_detail << "#{field} : #{self.send(field)}"
    end
    product_detail.join("\n")
  end
end

class Alex < Product
  def self.all
    super['alex']
  end
end

class Meena < Product
  def self.all
    super['meena']
  end
end

class Prabhu < Product
  def self.all
    super['prabhu']
  end
end

Product.import_data_source
Alex.all.each{ |product| puts product.details }
puts ' '
Meena.all.each{ |product| puts product.details }
puts ' '
Prabhu.all.each{ |product| puts product.details }