# coding: utf-8
require 'date'

class BookInfo
    # BookInfoクラスのインスタンスを初期化する
    def initialize(title, author, page, publish_date)
        @title = title
        @author = author
        @page = page
        @publish_date = publish_date
    end

    # 最初に検討する属性に対数アクセサを提供する
    attr_accessor :title, :author, :page, :publish_date

    # BookInfoクラスのインスタンスの文字列表現を返す
    def to_s
        "#{@title}, #{@author}, #{@page}, #{@publish_date}"
    end

    # 書籍データを書式をつけて出力する操作を追加する
    # 項目の区切り文字を引数に指定することができる
    # 引数を省略した場合は改行を区切り文字にする
    def to_formatted_string(sep = "\n")
        "書籍名: #{@title}#{sep}著者名: #{@author}#{sep}ページ数: #{@page}#{sep}発刊日: #{@publish_date}#{sep}"
    end
end

# BookInfoManagerクラスを定義する
class BookInfoManager
    def initialize
        @book_infos = {}
    end

    # 蔵書データをセットアップする
    def setup
        # 複数冊の蔵書データを登録する
        @book_infos['Yamada2005'] = BookInfo.new('実践アジャイル ソフトウェア開発法とプロジェクト管理', '山田 正樹', 248, Date.new(2005, 1, 25))
        @book_infos['Ooba2006'] =  BookInfo.new('入門LEGO MINDSTORMS NXT レゴブロックで作る動くロボット', '大庭 慎一郎', 164, Date.new(2006, 12, 23))
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
        print '発刊日" '
        day = gets.chomp.to_i
        book_info.publish_date = Date.new(year, month, day)

        # 作成した蔵書データの1件分をハッシュに登録する
        @book_infos[key] = book_info
    end

    # 蔵書データの一覧を表示する
    def list_all_bookinfos
        puts "\n---------------"
        @book_infos.each do |key, info|
            print info.to_formatted_string
            puts "\n---------------"
        end
    end

    # 処理の選択と選択後の処理を繰り返す
    def run
        while true
            # 機能選択画面を表示する
            print "1. 蔵書データの登録\n2. 蔵書データの表示\n9. 終了\n番号を選んでください(1,2,9): "
            
            # 文字の入力を待つ
            num = gets.chomp
            case num
            when '1'
                # 蔵書データの登録
                add_book_info
            when '2'
                # 蔵書データの表示
                list_all_bookinfos
            when '9'
                # アプリケーションの終了
                break
            else
                # 処理街画面に戻る
                puts '入力された数値が不正です'
            end
        end
    end
end

# アプリケーションのインスタンスを作る
book_info_manager = BookInfoManager.new

# BookInfoManagerの蔵書データをセットアップする
book_info_manager.setup

# BookInfoManagerの処理の選択と選択後の処理を繰り返す
book_info_manager.run
