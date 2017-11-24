require 'date'
# 日本語形式の日付に変換
# @param [Date] date 日付
# @return [String] 日付を YYYY年MM月DD日 の形式にしたもの
# @return [nil] 引数が Date 型以外の場合は nil
def convert_jp_date(date)
  (date.class == Date) ? date.strftime('%Y年%m月%d日') : nil
end
today = Date::today
puts convert_jp_date(today)

(データ/型/名前/説明の書き方)
# @タグ [型] <名前> <説明>

(例)
# @param  [Array]  arr表示したい配列
# @return [String] 空白を除去した文字列
@params   メソッドに渡す引数の説明
@raise    メソッドで発生しえる例外クラスの説明
@return   メソッドの返り値の説明
@option メソッドに渡すオプションハッシュ引数の説明

# @param       [ハッシュ] opts the options to create a message with.
# @option opts [String] :subject The subject
# @option opts [String] :from ('nobody') From address
# @option opts [String] :to Recipient email
# @option opts [String] :body ('') The email's body
def send_email(opts = {}) end
@overload 複数の引数のパターンがある場合にif文っぽく使う

# @overload set(key, value)
#   Sets a value on key
#   @param [Symbol] key describe key param
#   @param [Object] value describe value param
# @overload set(value)
#   Sets a value on the default key +:foo+
#   @param [Object] value describe value param
def set(*args) end
@example 直下の説明がサンプルコードであることを示す

# @example Reverse a String
#   "mystring".reverse #=> "gnirtsym"
def reverse; end
@see URLや他のオブジェクトを書くとリンクになる

# Synchronizes system time using NTP.
# @see http://ntp.org/documentation.html NTP Documentation
# @see NTPHelperMethods
class NTPUpdater; end
@note オブジェクトを使うときに注意して欲しい点を説明

# @note This method should only be used in outer space.
def eject; end
(中括弧)
{xxx} => リンクとみなす

(例)
# 詳細は、{http://rubydoc.info/docs/yard/0.7.2/file/docs/Tags.md Yardのタグ説明} を参照
🍣 YARDその他タグ一覧
@abstract 抽象クラス/モジュール/メソッドの説明
@api オブジェクトに属するAPIの説明。yardoc --queryで実行した場合のみ出力
@author 作者情報
@deprecated 非推奨のクラスやメソッドであることを表す
@private YARD出力時にオプションで出力しないようにできる。 yardoc --no-private 
@since メソッド・クラスが利用できるようになったバージョンを説明
@todo TODO
@version オブジェクトのバージョンを示す
@yield ブロックの説明。注意点としては、[]の中が引数となっていること。

# For a block {|a,b,c| ... }
# @yield [a, b, c] Gives 3 random numbers to the block
def provide3values(&block) yield(42, 42, 42) end

@yieldparam yieldのパラメータの説明

# @yieldparam [String] name the name that is yielded
def with_name(name) yield(name) end

@yieldreturn yieldの戻り値の説明

# @yieldreturn [Fixnum] the number to add 5 to.
def add5_block(&block) 5 + yield end
