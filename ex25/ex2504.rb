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

# WebrickのHTTP Serverクラスのサーバーインスタンスを作成する
server = WEBrick::HTTPServer.new(config)

# mount_procメソッドで、サーバーに実行時に処理する応答を追加する
# ここでは、'http://localhost:8099/testprog'で実行できる処理を追加
# reqはリクエスト情報の、resはレスポンスのハッシュ
server.mount_proc('/testprog') do |req, res|
    # アクセスした日付をレスポンスの内容に追加
    res.body << "<html lang='ja'><head><meta charset='UTF-8'></head><body><p>アクセスした日付は#{Date.today.to_s}です。</p>"
    res.body << "<p>リクエストのパスは#{req.path}でした。</p>"

    # リクエストの内容を、番号なしリストにしてレスポンスの内容に追加
    res.body << '<ul>'
    req.each do |key, value|
        res.body << "<li>#{key} : #{value}</li>"
    end
    res.body << '</ul>'
    res.body << '</body></html>'
end


# Ctrl-C割り込みがあった場合にサーバーを停止する処理を登録しておく
trap(:INT) do
    server.shutdown
end

# 上記記述の処理をこなすサーバーを開始する
server.start