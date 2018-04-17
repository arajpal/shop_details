# frozen_string_literal: true

$LOAD_PATH << '.'
require 'shop_data.rb'
require 'time'

# this class is directed by admin
class Admin
  include DataSource

  def find_user(name)
    specific_user = all_users
    specific_user.each do |user_data|
      user_data.each do |_key, value|
        next unless value == name
        print ' Details about ' + user_data[:first_name],
              + '' + user_data[:last_name] + "\n"
        puts user_data.to_s
      end
    end
  end
end

# this class contain the details aboout buyer and seller
class User
  include DataSource

  def name(category)
    user = all_users
    user.each do |user_data|
      user_data.each do |_key, value|
        if value == category
          print user_data[:first_name] + ' ' + user_data[:last_name],
                + ' as a ' + user_data[:role] + "\n"
        end
      end
    end
    puts "\n"
  end

  def details(category)
    user = all_users
    user.each do |user_data|
      user_data.each do |_key, value|
        puts user_data.to_s if value == category
      end
    end
    puts "\n"
  end

  def dob(category)
    all_users.each do |user_data|
      user_data.each do |_key, value|
        next unless value == category
        birth_date = Time.parse user_data[:date_of_birth]
        birth(birth_date)
        print ' age of ' + user_data[:first_name] + ' ',
              + user_data[:last_name] + " is #{@age}\n"
      end
    end
  end

  def birth(birth_date)
    current = Time.new
    current_year = current.year
    @age = if current.month > birth_date.month
             current_year.to_i - birth_date.year.to_i
           else
             current_year.to_i - birth_date.year.to_i - 1
           end
  end
end

admin = Admin.new
user = User.new
admin.details('products')
admin.details('users')
user.name('seller')
user.dob('seller')
user.details('seller')
admin.find_user('alex')
