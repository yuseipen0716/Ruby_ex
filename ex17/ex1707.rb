# coding: utf-8

# 配列にデータを作成
fruits = ['apple', 'banana', 'cherry', 'fig', 'grape']

# ファイル名を変数に割り当てる
fname = 'sample7.txt'

# 'sample4.txt'を書き込みモードで新規作成
open(fname, 'w:UTF-8') do |file|
    fruits.each do |fruit|
        file.puts fruit
    end
end

# 'sample7.txt'を読み込みモードでオープンする
open(fname, 'r:UTF-8') do |file|
    # ファイルの行を1行ずつ取り出して、lineに読み込む
    file.each do |line|
        print line
    end
end

# ファイルを削除する
File.delete(fname)

# 'sample7.txt'を読み込みモードでオープンする
# ファイルが削除されているのでエラーが発生するはず
open(fname, 'r:UTF-8')

