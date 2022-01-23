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
            puts 'データベースを初期化しました'
        end
    end
end

