require 'test/unit' 
require '../../lib/global/jwMulti'



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
      assert_equal(@t.childStringArray, ["a","b","\n\tc"])
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

    test "addchild, child class check, pass" do
      a = JWCSS.new
      @t.addChild a
    end

    test "addchild, multi class check, pass" do
      a = HEAD.new
      @t.addChild a      
    end

    test "add child" do
      b = BODY.new
      assert_equal(b.pressDefault, "<body>\n</body>")
    end

    
    
  end
end



# func test_body (){
 #        let bo = BODY()
 #        bo.press()
        
 #        /* answer
 #         <body>
 #         </body>
         
 #         */
 #    }
    
 #    func test_body_addchild (){
 #        let bo = BODY()
 #        bo.addCihld(child: "test")
 #        bo.press()
        
 #        /* answer
 #         <body>
 #            test
 #         </body>
         
 #         */
 #    }
 #    func test_body_addchild2 (){
 #        let bo = BODY()
 #        bo.addCihld(child: "test 1")
 #        bo.addCihld(child: "test 2")
 #        bo.addCihld(child: "test 3")

 #        bo.press()
        
 #        /* answer
 #         <body>
 #            test 1
 #            test 2
 #            test 3
 #         </body>
         
 #         */
 #    }
