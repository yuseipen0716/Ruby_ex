# coding: utf-8

require 'active_record'
require '../../mysql_cn/db_connect.rb'

class Product < ActiveRecord::Base
end

# delete機能のテストのためにid=3のレコードを作成  作成後はコメントアウトしておく
# Product.create(id: 3,
#     title: 'test',
#     description: 'デリート機能のテスト',
#     image_url: '/images/test.jpg',
#     price: 400,
#     date_available: '2009-02-02 02:15:00'
# );

# Productsテーブルに登録されているレコードを表示する id=3のレコードが追加されていることを確認
# (Product.first.id..Product.last.id).each do |id|
#     puts "id: #{Product.find_by(id: id).id}"
#     puts "title: #{Product.find_by(id: id).title}"
#     puts "description: #{Product.find_by(id: id).description}"
#     puts "image_url: #{Product.find_by(id: id).image_url}"
#     puts "price: #{Product.find_by(id: id).price}"
#     puts "date_aveilable: #{Product.find_by(id: id).date_available}"
#     puts '---------------'
# end

# delete対象としてid=3のレコードをproductに代入しておく
# delete_test = Product.find_by(id: 3)

# delete_testをdestroyしてデータベースから削除
# delete_test.destroy

# Productsテーブルに登録されているレコードを表示する id=3のレコードが削除されていることを確認
(Product.first.id..Product.last.id).each do |id|
    puts "id: #{Product.find_by(id: id).id}"
    puts "title: #{Product.find_by(id: id).title}"
    puts "description: #{Product.find_by(id: id).description}"
    puts "image_url: #{Product.find_by(id: id).image_url}"
    puts "price: #{Product.find_by(id: id).price}"
    puts "date_aveilable: #{Product.find_by(id: id).date_available}"
    puts '---------------'
end
