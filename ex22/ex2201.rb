# coding: utf-8
require 'yaml'
require 'active_record'
require 'date'


class BookInfo
    # BookInfoのクラスのインスタンスを初期化する
    def initialize(title, author, page, publish_date)
        @title = title
        @author = author
        @page = page
        @publish_date = publish_date
    end

    # 最初に検討する属性に対するアクセサを提供する
    attr_accessor :title, :author, :page, :publish_date

    # BookInfoクラスのインスタンスの文字列表現を返す
    def to_s
        "#{@title}, #{@author}, #{@page}, #{@publish_date}"
    end

    # 蔵書データに書式をつけて出力する操作を追加する
    # 項目の区切り文字を引数に指定することができる
    # 引数を省略した場合は改行を区切り文字にする
    def to_formatted_string(sep = "\n")
        "書籍名: #{@title}#{sep}著者名: #{@author}#{sep}ページ数: #{@page}ページ#{sep}発刊日: #{@publish_date}#{sep}"
    end
end

class Bookinfo < ActiveRecord::Base
end

class BookInfoManager
    # databaseの接続情報を記載したyamlファイルのファイルパスを引数にしたinitializeメソッドを定義
    # 引数を指定しなくても既存のyamlファイルを読み込み、接続ができるようにdefault値を設定しておく
    def initialize(yaml_file_path = '../../mysql_cn/database.yml')
        @yaml_file_path = yaml_file_path
        # データベースに接続
        config = YAML.load_file(@yaml_file_path)
        ActiveRecord::Base.establish_connection(config['db']['bookinfos'])
        puts "データベースに接続しました\n"
    end

    # 蔵書データベースを初期化する
    def init_bookinfos
        puts "\n0. 蔵書データベースの初期化"
        print '初期化しますか？( Y/y なら初期化を実行します。): '
        # 読み込んだ値を大文字に揃える
        yesno = gets.chomp.upcase
        if /^Y$/ =~ yesno
            # Yが1文字の時だけ、初期化を実行する
            Bookinfo.destroy_all
            puts "データベースを初期化しました\n"
        end
    end

    # 蔵書データを登録する
    def add_book_info
        puts "\n1. 蔵書データの登録"
        puts '蔵書データを登録します'

        # 蔵書データ1件分のインスタンスを作成する
        book_info = BookInfo.new('', '', 0, Date.new)
        # 登録するデータを項目ごとに入力する
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

        # idを取得
        

        # 作成した蔵書データをデータベースに登録する
        Bookinfo.create(
            # idは1から始まる連番にしたい。（auto_incrementにすればいい話かもだけど)
            # 最後の蔵書データが存在する場合はそのIDに1を加えたものを今回のidにする
            # id = 1のデータが存在する場合、という条件で設定していたが、id = 1のレコードを削除していた場合に
            # 不具合が生じるのでこのようにした。もっといい方法募集中。
            if Bookinfo.last.exist?
                id: Bookinfo.last.id + 1,
            else
                id: 1,
            end
            # ここから下で登録するカラムは上で作成したインスタンスから引っ張ってくる
            title: book_info.title,
            author: book_info.author,
            page: book_info.page,
            publish_date: book_info.publish_date
        );
    end

#     # 蔵書データの一覧を表示する
#     def list_all_bookinfos
#         puts "\n2. 蔵書データの表示"
#         puts "蔵書データを表示します\n---------------"

#         # テーブルからデータを読み込んで表示する
#         counter = 0
#         (Bookinfo.first.id..Bookinfo.last.id).each do |id|
#             puts "id: #{Bookinfo.find_by(id: id).id}"
#             puts "title: #{Bookinfo.find_by(id: id).title}"
#             puts "author: #{Bookinfo.find_by(id: id).author}"
#             puts "page: #{Bookinfo.find_by(id: id).page}"
#             puts "publish_date: #{Bookinfo.find_by(id: id).publish_date}"
#             puts '---------------'
#             counter += 1
#         end
#         puts "#{counter}件のデータを表示しました。"
#     end

#     # 処理の選択と選択後の処理を繰り返す
    def run
        while true
            # 機能選択画面を表示する
            print "0. 蔵書データベースの初期化\n1. 蔵書データの登録 \n2. 蔵書データの表示 \n9. 終了\n番号を選んでください(0, 1, 2, 9): "

            # 文字の入力を待つ
            num = gets.chomp
            case num
            when '0'
                # 蔵書データベースの初期化
                init_bookinfos
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
                # 処理待ち画面に戻る
                puts '入力された数値が不正です'
            end
        end
    end
end

book_info_manager = BookInfoManager.new
book_info_manager.run

