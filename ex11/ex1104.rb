# coding: utf-8

str = 'Twinkle, twinkle, little star,
How I wonder what you are.
Up above the world so high,
Like a diamond in the sky.
Twinkle, twinkle, little star,
How I wonder what you are..'

# 上の歌詞を行ごとに分割
lines = str.split(/\n/)

# 'you'nいマッチする行を表示する
puts 'youが含まれていた行'
lines.each do |line|
    if line =~ /[Yy]ou/
        puts line
    end
end

puts ''

# 行末に','が来ている行を表示する
puts '行末にカンマが含まれていた行'
lines.each do |line|
    if line =~ /,$/
        puts line
    end
end

puts ''

# 'i'がきて2文字おいて'1'がくる文字列が含まれる
puts '"i"がきて2文字おいて"1"がくる文字列が含まれる'
lines.each do |line|
    if line =~ /i..l/
        puts line
    end
end

