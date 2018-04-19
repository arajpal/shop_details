# frozen_string_literal: true

require 'yaml'
require 'time'

# contain all the data and method of user
class User
  @@user = {}
  ATTR_USER = [:first_name, :last_name, :date_of_birth, :address, :role ]

  ATTR_USER.each do |field|
    attr_accessor field
  end

  def self.data_source
    user_details = YAML.load_file 'users_data.yaml'
    user_details.each do |user_detail|
      @@user[user_detail[:role]] ||= []
      @@user[user_detail[:role]] << self.new(user_detail)
    end
  end

  def initialize(user_detail)
    self.first_name = user_detail[:first_name]
    self.last_name = user_detail[:last_name]
    self.date_of_birth = user_detail[:date_of_birth]
    self.address = user_detail[:address]
    self.role = user_detail[:role]
  end

  def self.all
    p @@user
  end

  define_method 'age' do
    Time.new.year - Time.parse(self.date_of_birth).year
  end

  define_method 'full_name' do
    "#{self.first_name} #{self.last_name}"
  end

  define_method 'details' do
    user_detail = []
    ATTR_USER.each do |field|
      user_detail << "#{field} : #{self.send(field)}"
    end
    user_detail.join("\n")
  end
end

# buyer class
class Buyer < User
  def self.all
    super['buyer']
  end
end

# seller class
class Seller < User
  def self.all
    super['seller']
  end
end

User.data_source
user1 = Buyer.all.each{ |buyer| puts buyer.age }
user1 = Buyer.all.each{ |buyer| puts buyer.full_name}
user1 = Buyer.all.each{ |buyer| puts buyer.details}
puts ''
Seller.all.each{ |seller| puts seller.age }
Seller.all.each{ |seller| puts seller.full_name }
Seller.all.each{ |seller| puts seller.details }
