# coding: utf-8

require 'date'

# 表示したい蔵書データを作成する

publish_date = Date.new(2005, 1, 25)
mon_name = Date::MONTHNAMES[publish_date.month]
abbr_mon_name = Date::ABBR_MONTHNAMES[publish_date.month]

# 蔵書データを表示する

puts '出版年: ' + publish_date.year.to_s
puts '出版月(長い名前): ' + mon_name
puts '出版月(短い名前): ' + abbr_mon_name

