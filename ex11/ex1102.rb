# coding: utf-8

# 新しいハッシュを作る
friends = {shin: 'Shin Kuboaki', shinichirou: 'Shinichirou Ooba', shingo: 'Shingo Katori'}

# ハッシュの要素を一つずつ処理する
# 繰り返しの都度、キーと値をブロック内のローカル変数key, valueに渡す
friends.each_key{|key| 
    # ローカル変数keyの値を表示する
    puts "#{key}"
}
