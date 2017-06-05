require 'test/unit' 
require '../../lib/global/jwMulti'
require '../../lib/global/jw_CSS_JS'

module Jabverwock
  using StringExtension
  class JwMultiTest < Test::Unit::TestCase
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
      @t = JWMulti.new
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

    # test "confirm path" do
    #    p @t
    # end
        
    test "addChildString, without RET" do
      @t.childStringArray = ["a","b"]
      @t.addChildString "c"
      assert_equal(@t.childStringArray, ["a","b","c"])
    end

    test "addChildString with RET" do
      @t.childStringArray = ["a","b"]
      @t.addChildString "\nc"
      assert_equal(@t.childStringArray, ["a","b","\nc"])
    end

    test "addchild, class check, asert raise" do
      assert_raise{
        @t.addChild "a"
      }
    end
    
    test "addchild, class check, pass" do
      a = JW.new
      assert_raise{
        @t.addChild a
      }

    end

    # test "addchild, child class check, pass" do
    #   a = JW_CSS.new
    #   @t.addChild a
    # end


    test "body check before add child" do
      b = BODY.new
      assert_equal(b.pressDefault, "<body>\n</body>")
    end

    test "body addchildString string" do
      b = BODY.new
      bc = "dd"
      b.addChildString bc
      assert_equal(b.pressDefault, "<body>\ndd\n</body>")      
    end
    
    test "body addChildStrings" do
      b = BODY.new
      bc = "dd"
      b.addChildString bc
      b.addChildString bc
      b.addChildString bc
      
      assert_equal(b.pressDefault, "<body>\ndd\ndd\ndd\n</body>")            
    end

    test "head confirm, because script tag add after treatment" do
      a = HEAD.new
      assert_equal a.pressDefault, "<head>\n</head>"
    end
    
    test "addchild, multi class check, pass" do
      a = HEAD.new
      @t.addChild a
    
      assert_equal(@t.pressDefault, "<jwmulti>\n<head>\n</head>\n</jwmulti>")
    end
    
    test "addchildren" do
      b = BODY.new
      c = HEAD.new
      @t.addChildren [b, c]
      
      # same result
      # @t.addChildren b, c
      
      assert_equal(@t.pressDefault,"<jwmulti>\n<body>\n</body>\n<head>\n</head>\n</jwmulti>")  
    end
    
  end
end
