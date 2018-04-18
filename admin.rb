# frozen_string_literal: true

$LOAD_PATH << '.'
require 'shop_data.rb'
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

admin = Admin.new
admin.details('products')
admin.details('users')
admin.find_user('alex')
