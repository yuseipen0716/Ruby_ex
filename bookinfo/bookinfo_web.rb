# coding: utf-8
require 'webrick'

# サーバーの設定を書いたハッシュを用意する
# ポートは通常使う80番ではなく、使ってなさそうなポート番号にしておく。
# 8099は空いてそうなポート番号の例
# DocumentRootは文書のある場所
# ここでは現在のディレクトリを表す「.」と指定している。
config = {
    :Port => 8099,
    :DocumentRoot => '.',
}

# 拡張子erbのファイルを、ERBを呼び出して処理するERBHandlerと関連づける
WEBrick::HTTPServlet::FileHandler.add_handler('erb',WEBrick::HTTPServlet::ERBHandler)

# WebrickのHTTP Serverクラスのサーバーインスタンスを作成する
server = WEBrick::HTTPServer.new(config)

# erbのMIMEタイプを設定
server.config[:MimeTypes]['erb'] = 'text/html'

# 一覧表示からの処理
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


# Ctrl-C割り込みがあった場合にサーバーを停止する処理を登録しておく
trap(:INT) do
    server.shutdown
end

# 上記記述の処理をこなすサーバーを開始する
server.start