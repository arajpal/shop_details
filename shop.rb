$LOAD_PATH << '.'
require 'shop_data.rb'
require 'time'

# this class is directed by admin
class Admin
  include Shop

  def find_user(name)
    specific_user = all_users
    specific_user.each do |user_data|
      user_data.each do |_key, value|
        if value == name
          print ' Details about ' + user_data[:first_name],
                + '' + user_data[:last_name] + "\n"
          puts user_data.to_s
        end
      end
    end
  end
end

# this class contain the details aboout buyer and seller
class User
  include Shop

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
        if value == category
          puts user_data.to_s
        end
      end
    end
    puts "\n"
  end

  def dob(category)
    puts "Age of #{category}'s\n"
    current = Time.new

    user = all_users
    user.each do |user_data|
      user_data.each do |_key, value|
        if value == category
          dob =  user_data[:date_of_birth]
          dob = Time.parse dob
          if current.month > dob.month
            age = current.year.to_i - dob.year.to_i
          else
            age = current.year.to_i - dob.year.to_i - 1
          end
          print ' age of ' + user_data[:first_name] + ' ',
                + user_data[:last_name] + " is #{age}\n"
        end
      end
    end
    puts "\n\n"
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
