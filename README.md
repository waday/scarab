# scarab
- bin/make_stock_list.rb
指定の市場から銘柄リストを作成するスクリプト
- bin/get_price_data.rb:
銘柄リストを元に株価情報をYahoo!ファイナンスから落としてくるスクリプト。株価情報は`data`ディレクトリにテキストファイル形式で保管される　
- bin/update_price_data.rb
get_price_dataで取得した株価情報を最新情報に更新する。cronとかで実行してやるといいかも

