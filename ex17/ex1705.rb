# coding: utf-8

# 配列にデータを作成
indians = ["One little, two little, three little Indians\n",
            "Four little, five little, six little Indians\n", 
            "Seven little, eight little, nine little Indians\n",
            "Ten little Indian boys.\n"]


# 'sample5.txt'を書き込みモードで新規作成
file = File.open('sample5.txt', 'w:UTF-8')
indians.each do |indian|
    file.print indian
end

# ファイルを閉じる
file.close

# 'sample5.txt'を読み込みモードでオープンする
file = open('sample5.txt', 'r:UTF-8')

# ファイルからデータを全て読み込み、それを表示する
print file.read

# ファイルを閉じる
file.close

