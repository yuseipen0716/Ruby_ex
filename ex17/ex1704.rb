# coding: utf-8

# 配列にデータを作成
fruits = ['apple', 'banana', 'cherry', 'fig', 'grape']

# 'sample4.txt'を書き込みモードで新規作成
file = File.open('sample4.txt', 'w:UTF-8')
fruits.each do |fruit|
    file.puts fruit
end

# ファイルを閉じる
file.close

# 'sample4.txt'を読み込みモードでオープンする
file = open('sample4.txt', 'r:UTF-8')

# ファイルからデータをすべて読み込み、それを表示する
print file.read

# ファイルを閉じる
file.close

