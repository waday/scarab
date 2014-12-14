require "./lib/base"

### 仕掛けを制限する
# - 本クラスを継承するサブクラスはfilterメソッドを実装すること
# - filterメソッドは、:no_entry, :long_only, :short_only, :long_and_shortのいずれかを返却する
#   :no_entry => 仕掛けシグナルが出ても仕掛けない
#   :long_only => 買いシグナルが出た時だけ仕掛ける
#   :short_only => 売りシグナルが出た時だけ仕掛ける
#   :long_and_short => 買い売りのシグナル関係なく仕掛ける
class Filter < Rule
  def get_filter(index)
    with_valid_indicators {filter(index)}
  end
end
