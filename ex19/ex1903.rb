# coding: utf-8

require 'date'
require 'pstore'

class BookInfo
    # BookInfoクラスのインスタンスを初期化する
    def initialize(title, author, page, publish_date)
        @title = title
        @author = author
        @page = page
        @publish_date = publish_date
    end

    # 最初に検討する属性に対するアクセサを提供する
    attr_accessor :title, :author, :page, :publish_date

    # BookInfoクラスのインスタンスをCSV形式へ変換する
    def to_csv(key)
        "#{key},#{@title},#{@author},#{@page},#{@publish_date}\n"
    end

    # BookInfoクラスのインスタンスの文字列表現を返す
    def to_s
        "#{@title}, #{@author}, #{@page}, #{@publish_date}"
    end

    # 蔵書データを書式をつけて出力する操作を追加する
    # 項目の区切り文字を引数に指定することができる
    # 引数を省略した場合は改行を区切り文字にする
    def to_formatted_string(sep = "\n")
        "書籍名: #{@title}#{sep}著者名: #{@author}#{sep}ページ数: #{@page}ページ#{sep}発刊日: #{@publish_date}#{sep}"
    end
end

# BookInfoManagerクラスを定義する
class BookInfoManager
    def initialize(pstore_name)
        # PStoreのデータベースファイルを指定して初期化
        @db = PStore.new(pstore_name)
    end

    # 蔵書データを登録する
    def add_book_info
        # 蔵書データ1件分のインスタンスを作成する
        book_info = BookInfo.new('', '', 0, Date.new)
        # 登録するデータを項目ごとに入力する
        print "\n"
        print 'キー: '
        key = gets.chomp
        print '書籍名: '
        book_info.title = gets.chomp
        print '著者名: '
        book_info.author = gets.chomp
        print 'ページ数: '
        book_info.page = gets.chomp.to_i
        print '発刊年: '
        year = gets.chomp.to_i
        print '発刊月: '
        month = gets.chomp.to_i
        print '発刊日: '
        day = gets.chomp.to_i
        book_info.publish_date = Date.new(year, month, day)

        # 作成した蔵書データ1件分をPStoreデータベースに登録する
        @db.transaction do
            # 蔵書データをPStoreに保存する
            @db[key] = book_info
        end
    end

    # 蔵書データの一覧を表示する
    def list_all_bookinfos
        puts "\n---------------"
        @db.transaction(true) do
            # rootsがキーの配列を返し、eachでそれを1件ずつ処理
            @db.roots.each do |key|
                # 得られたキーを使ってPStoreから蔵書データ(BookINfo)を取得
                # それを書式をつけて出力する
               puts "キー: #{key}"
               print @db[key].to_formatted_string
               puts "\n---------------"
            end
        end
    end

    # 蔵書データを削除する
    def del_bookinfo
        # キーを指定してもらう
        print "\n"
        print 'キーを指定してください: '
        key = gets.chomp

        # 削除対象データを確認してから削除する
        @db.transaction do
            if @db.root?(key)
                print @db[key].to_formatted_string
                print "\n削除しますか?(Y/yなら削除を実行します): "
                yesno = gets.chomp.upcase
                if /^Y$/ =~yesno
                    # Yが1文字のときだけ、PStoreデータベースから削除する
                    @db.delete(key)
                    puts "\nデータベースから削除しました"
                end
            end
        end
    end

    # 処理の選択と選択後の処理を繰り返す
    def run
        while true
            # 機能選択画面を表示する
            print "1. 蔵書データの登録 \n2. 蔵書データの表示 \n3. 蔵書データの削除 \n9. 終了\n番号を選んでください(1, 2, 3, 9): "

            # 文字の入力を待つ
            num = gets.chomp
            case num
            when '1'
                # 蔵書データの登録
                add_book_info
            when '2'
                # 蔵書データの表示
                list_all_bookinfos
            when '3'
                # 蔵書データの削除
                del_bookinfo
            when '9'
                # アプリケーションの終了
                break
            else
                # 処理待ち画面に戻る
                puts '入力された数値が不正です'
            end
        end
    end

end

# ここからがアプリケーションを動かす本体

# アプリケーションのインスタンスを作る
# 蔵書データのPStoreデータベース指定している
book_info_manager = BookInfoManager.new('book_info.db')

# BookInfoManagerの処理の選択と選択後の処理を繰り返す
book_info_manager.run











