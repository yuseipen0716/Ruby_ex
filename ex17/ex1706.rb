# coding: utf-8

# 'sample1.txt'を読み込みモードでオープンする
open('sample1.txt', 'r:UTF-8') do |file|
    # 処理はブロックとして渡す
    # ファイルの行を1行ずつ取り出して、lineに読み込む
    file.each do |line|
        # lineを表示する
        print line
    end
end
# ファイルは自動で閉じてもらえる

