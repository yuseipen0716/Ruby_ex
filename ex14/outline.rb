# coding: utf-8

# まずはBookInfoManagerのアウトラインをつくる

# BookInfoManagerクラスを定義する
class BookInfoManager
    def initialize
       @book_infos = {} 
    end

    # 蔵書データをセットアップする
    def setup
       # 複数冊の蔵書データを登録する
       @book_infos['Yamada2005'] = 
    end

    # 処理の選択と選択後の処理を繰り返す
    def run
        
    end
end

# アプリケーションのインスタンスをつくる
book_info_manager = BookInfoManager.new

# BookInfoManagerのデータをセットアップする
book_info_manager.setup

# BookInfoManagerの処理の選択と選択後の処理を繰り返す
book_info_manager.run


