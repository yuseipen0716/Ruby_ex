# coding: utf-8

require 'active_record'
require '../../mysql_cn/db_connect.rb'

class Product < ActiveRecord::Base
end

(Product.first.id..Product.last.id).each do |id|
    puts "id: #{Product.find_by(id: id).id}"
    puts "title: #{Product.find_by(id: id).title}"
    puts "description: #{Product.find_by(id: id).description}"
    puts "image_url: #{Product.find_by(id: id).image_url}"
    puts "price: #{Product.find_by(id: id).price}"
    puts "date_aveilable: #{Product.find_by(id: id).date_available}"
    puts '---------------'
end