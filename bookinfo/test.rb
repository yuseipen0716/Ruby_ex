# coding: utf-8
require 'yaml'
require 'active_record'

class Product < ActiveRecord::Base
end

config = YAML.load_file('../../mysql_cn/database.yml')
ActiveRecord::Base.establish_connection(config['db']['sample'])

# p Product.column_names[0]

# p Product.first.attributes.keys
# p Product.first.attributes.values

# (0..Product.attributes.size-1).each do |key, value|
#     puts "#{Product.column_names[column]}: #{Product.find_by(id: id)}"
# end

# (Product.first.id..Product.last.id).each do |id|
#     (0..Product.column_names.size-1).each do |column|
#         puts "#{Product.find_by(id: id).attributes.keys[column]}: #{Product.find_by(id: id).attributes.values[column]}"
#     end
#     puts '---------------'
# end

Product.all.each do |product|
    (0..product.attributes.size-1).each do |column|
        puts "#{product.attributes.keys[column]}: #{product.attributes.values[column]}"
    end
    puts '---------------'
end
sql = ""
p ActiveRecord::Base.connection.select_all(sql) if sql != ""

puts '該当データはありません' if sql == ""

# p Product.all

# <%# select文の実行結果を1件ずつ取り出して繰り返し処理 %>
# <% (Bookinfo.first.id..Bookinfo.last.id).each do |id| %>
#     <tr>
#     <% (0..Bookinfo.find_by(id: id).attributes.size-1).each do |column| %>
#         <% if Bookinfo.find_by_id(id: id).attributes.keys[column] == 'id' %>
#             <%# valueに選択したidの値の後に処理(.delete, .edit)を結合した文字列を設定 %>
#             <td><input type='radio' name='operation' value=<%="#{Bookinfo.find_by(id: id).id}.delete"%> /></td>
#             <td><input type='radio' name='operation' value=<%="#{Bookinfo.find_by(id: id).id}.edit"%> /></td>
#         <% end %>
#         <td><%= "#{Bookinfo.find_by(id: id).attributes.values[column].to_s}" %></td>
#     <% end %>
#     </tr>
# <% end %>

# <%# select文の実行結果を1件ずつ取り出して繰り返し処理 %>
# <% (Bookinfo.first.id..Bookinfo.last.id).each do |id| %>
#     <tr>
#     <% (0..Bookinfo.find_by(id: id).attributes.size-1).each do |column| %>
#         <% if column == 1 %>
#             <%# valueに選択したidの値の後に処理(.delete, .edit)を結合した文字列を設定 %>
#             <td><input type='radio' name='operation' value=<%="#{Bookinfo.find_by(id: id).id}.delete"%> /></td>
#             <td><input type='radio' name='operation' value=<%="#{Bookinfo.find_by(id: id).id}.edit"%> /></td>
#         <% end %>
#         <td><%= "#{Bookinfo.find_by(id: id).attributes.values[column].to_s}" %></td>
#     <% end %>
#     </tr>
# <% end %>

# id = 2

# check = Product.find_by(id: id)
# p check
# if check
#     puts 'idが重複しています'
# end