require 'test/unit'
require '../../GLOBAL/GlobalDef' # => true
require '../../GLOBAL/JW.rb'# => true

class JSTest < Test::Unit::TestCase
  class << self
    # テスト群の実行前に呼ばれる．変な初期化トリックがいらなくなる
    def startup
      p :_startup
    end

    # テスト群の実行後に呼ばれる
    def shutdown
      p :_shutdown
    end
  end

   # 毎回テスト実行前に呼ばれる
  def setup
    p :setup
  end

  # テストがpassedになっている場合に，テスト実行後に呼ばれる．テスト後の状態確認とかに使える
  def cleanup
    p :cleanup
  end

  # 毎回テスト実行後に呼ばれる
  def teardown
    p :treadown
  end

  ############## test ###############
  
  test "JW use InsertData as Struct " do
    a = InsertData.new("test",1)
    assert_equal(a.label, "test")
      
  end
  
  
end

# >> Loaded suite /var/folders/87/r0sr2xy176l6vnw1b8hffgtc0000gn/T/seeing_is_believing_temp_dir20170125-56516-6nbm1y/program
# >> Started
# >> :_startup
# >> :setup
# >> :cleanup
# >> :treadown
# >> .:_shutdown
# >> 
# >> 
# >> Finished in 0.000512 seconds.
# >> ------
# >> 1 tests, 1 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
# >> 100% passed
# >> ------
# >> 1953.12 tests/s, 1953.12 assertions/s

