# coding: utf-8
require 'webrick'
require 'yaml'
require 'active_record'

class Bookinfo < ActiveRecord::Base
end

# サーバーの設定を書いたハッシュを用意する
# ポートは通常使う80番ではなく、使ってなさそうなポート番号にしておく。
# 8099は空いてそうなポート番号の例
# DocumentRootは文書のある場所
# ここでは現在のディレクトリを表す「.」と指定している。
config = {
    :Port => 8099,
    :DocumentRoot => '.',
    :CGIInterpreter => '/usr/bin/ruby-Eutf-8:utf-8'
}

# 拡張子erbのファイルを、ERBを呼び出して処理するERBHandlerと関連づける
WEBrick::HTTPServlet::FileHandler.add_handler('erb',WEBrick::HTTPServlet::ERBHandler)

# WebrickのHTTP Serverクラスのサーバーインスタンスを作成する
server = WEBrick::HTTPServer.new(config)

# erbのMIMEタイプを設定
server.config[:MimeTypes]['erb'] = 'text/html'


# ==========  一覧表示からの処理 ========== 
# 'http://localhost:8099/list'で呼び出される。
server.mount_proc('/list') do |req, res|
    p req.query
    # 'operation'の値の後の(.delete, .edit)で処理を分岐する
    if /(.*)\.(delete|edit)$/ =~ req.query['operation']
        target_id = $1
        operation = $2
        # 選択された処理を実行する画面に移行する
        # ERBをERBHandlerを経由せずに直接呼び出して利用している。
        if operation == 'delete'
            template = ERB.new(File.read('delete.erb'))
        elsif operation == 'edit'
            template = ERB.new(File.read('edit.erb'))
        end
        res.body << template.result(binding)
    else # データが渡されていないなど
        template = ERB.new(File.read('noselected.erb'))
        res.body << template.result(binding)
    end
end


# ==========  登録の処理 ========== 
# 'http://localhost:8099/entry'で呼び出される
server.mount_proc('/entry') do |req, res|
    # 本来ならここで入力データに危険や不正がないかチェックするが、演習の見通しのために割愛している
    p req.query
    # データベースに接続する
    config = YAML.load_file('../../mysql_cn/database.yml')
    ActiveRecord::Base.establish_connection(config['db']['bookinfos'])

    # idが使用されていた場合は登録できないようにする
    # 入力されたidをid_checkerに格納して、下記のif文でデータベースにそのidが存在するか評価
    input_id = req.query['id']
    id_checker = Bookinfo.find_by(id: input_id)
    if id_checker
        # 処理の結果を表示する
        # ERBをERBHandlerを経由せずに直接呼び出して利用している
        template = ERB.new(File.read('noentried.erb'))
        res.body << template.result(binding)
    else # id_checkerがnilなら登録作業を実施
        Bookinfo.create(
            id: req.query['id'].force_encoding('utf-8'),
            title: req.query['title'].force_encoding('utf-8'),
            author: req.query['author'].force_encoding('utf-8'),
            page: req.query['page'].force_encoding('utf-8'),
            publish_date: req.query['publish_date'].force_encoding('utf-8')
        );
        # 処理の結果を表示する
        # ERBをERBHandlerを経由せずに直接呼び出して利用している
        template = ERB.new(File.read('entried.erb'))
        res.body << template.result(binding)
    end
end


# ==========  検索の処理 ==========
# 'http://localhost:8099/retrieve'で呼び出される
server.mount_proc('/retrieve') do |req, res|
    # 本来ならここで入力データに危険や不正がないかチェックするが、演習の見通しのために割愛している
    p req.query

    # 検索条件の整理
    search_column = ['id', 'title', 'author', 'page', 'publish_date']
    # 問い合わせ条件のある要素以外を削除
    search_column.delete_if{|name| req.query[name] == ""}

    if search_column.empty?
        where_data = ""
        sql = where_data
    else
        # 残った要素を検索条件文字列に変換
        search_column.map!{|name| "#{name}='#{req.query[name]}'"}
        where_data = "where " + search_column.join(' or ')
        
        sql = "select * from bookinfos #{where_data};"
        p sql
        # where_data.each do |i|
        #     p i
        # end
        # データベースに接続する
        # config = YAML.load_file('../../mysql_cn/database.yml')
        # ActiveRecord::Base.establish_connection(config['db']['bookinfos'])
        # p ActiveRecord::Base.connection.select_all("select * from bookinfos #{where_data};")
    end
    
    # 処理の結果を表示する
    # ERBをERBHandlerを経由せずに直接呼び出して利用している
    template = ERB.new(File.read('retrieved.erb'))
    res.body << template.result(binding)
end

# ==========  修正の処理 ========== 
# 'http://localhost:8099/edit'で呼び出される
server.mount_proc('/edit') do |req, res|
    # 本来ならここで入力データに危険や不正がないかチェックするが、演習の見通しのために割愛している
    p req.query
    # データベースに接続する
    config = YAML.load_file('../../mysql_cn/database.yml')
    ActiveRecord::Base.establish_connection(config['db']['bookinfos'])

    # テーブルのデータを更新する
    sql = "update bookinfos set id='#{req.query['id'].force_encoding('utf-8')}', title='#{req.query['title'].force_encoding('utf-8')}', 
    author='#{req.query['author'].force_encoding('utf-8')}', page='#{req.query['page'].force_encoding('utf-8')}', 
    publish_date='#{req.query['publish_date'].gsub(/[a-zA-Z]/,'').force_encoding('utf-8')}' where id='#{req.query['id']}';"
    ActiveRecord::Base.connection.execute(sql)
    # p Bookinfo.find_by(id: req.query['id'].to_i) デバッグ用

    # 処理の結果を表示する
    # ERBをERBHandlerを経由せずに直接呼び出して利用している
    template = ERB.new(File.read('edited.erb'))
    res.body << template.result(binding)
end

# ==========  削除の処理 ==========
# 'http://localhost:8099/delete'で呼び出される
server.mount_proc('/delete') do |req, res|
    # 本来ならここで入力データに危険や不正がないかチェックするが、演習の見通しのために割愛している
    p req.query
    # データベースに接続する
    config = YAML.load_file('../../mysql_cn/database.yml')
    ActiveRecord::Base.establish_connection(config['db']['bookinfos'])

    # テーブルからデータを削除する
    Bookinfo.destroy_by(id: req.query['id'].to_i)

    # 処理の結果を表示する
    # ERBをERBHandlerを経由せずに直接呼び出して利用している
    template = ERB.new(File.read('deleted.erb'))
    res.body << template.result(binding).force_encoding('utf-8') # encordingでエラーが出たので
end



# Ctrl-C割り込みがあった場合にサーバーを停止する処理を登録しておく
trap(:INT) do
    server.shutdown
end

# 上記記述の処理をこなすサーバーを開始する
server.start