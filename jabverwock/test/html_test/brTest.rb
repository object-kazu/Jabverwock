require 'test/unit' 
require '../../lib/global/jwSingle'

module Jabverwock
  using StringExtension
  
  class BRTest < Test::Unit::TestCase
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
      @br = BR.new
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
    test "single List" do
      assert_equal(@br.name , "br")
    end

    test "br basically" do
      @br.content = "this is test"
      assert_equal(@br.pressDefault, "this is test<br>")
    end

    test "br with p tag" do
      @br.content = "this is test"
      pp = P.new
      pp.content = @br.tgStr
      assert_equal(pp.pressDefault,"<p>this is test<br></p>")
      
    end
    
    
  end
end
 
