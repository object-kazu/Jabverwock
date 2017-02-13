require 'test/unit' 
require '../../lib/global/jwSingle'

module Jabverwock
  using StringExtension
  
  class ATest < Test::Unit::TestCase
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
      @a = A.new
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
      a = A.new
      assert_equal(a.name , "a")
    end

    test "A first test" do
      ans = @a.pressDefault
      assert_equal(ans, "<a></a>")
    end

    test "add member, do not use same name" do
      
      j1 = A.new
      j1.css.color("red").font_size(10)
      assert_equal(j1.showCssString, "a {\ncolor: red;\nfont-size: 10;\n}")     
    end

    
    # test "content add" do
    #   @a.name="j"
    #   @a.content = "test"
    #   ans = @a.pressDefault
    #   ans2 = @a.pressVal.showTempleteString
      
    #   assert_equal(ans, "<j>test</j>")
    #   assert_equal(ans, ans2)
    # end
    
    # test "add label case 1" do

    #   @a.name="j"
    #   @a.content = "test" + "a".variable
    #   ans = @a.pressDefault
    #   ans2 = @a.pressVal.showTempleteString
      
    #   assert_equal(ans, "<j>test</j>")
    #   assert_not_equal(ans, ans2)
      
    # #     // not equal <j>testLABEL_INSERT_START + "a" + LABEL_INSERT_END</j>
    # #     // because at press method , remove LABEL_INSERT_START + "a" + LABEL_INSERT_END
      
    # end

    
    # test "add label case 2" do
    #   @a.name="j"
    #   @a.content = "test" + "a".variable
    #   @a.pressDefault
    #   ans = @a.pressAInsert("a".varIs" is done")
    #   assert_equal(ans, "<j>test is done</j>")

    # end
    
    # test "add label case 3" do
    #   @a.name="j"
    #   @a.content = "test" + "a".variable + "-> yes!"
    #   @a.pressDefault
    #   ans = @a.pressAInsert("a".varIs" is done")
    #   assert_equal(ans, "<j>test is done-> yes!</j>")
      
    # end
    
    # test "add label case 4, retry insert data" do
    #   @a.name="j"
    #   @a.content = "test" + "a".variable + "-> yes!"
    #   @a.pressDefault
    #   ans = @a.pressAInsert("a".varIs" is done")
    #   assert_equal(ans, "<j>test is done-> yes!</j>")

    #   #retry
    #   ans2 = @a.pressAInsert("a".varIs" was success!")
    #   assert_equal(ans2, "<j>test was success!-> yes!</j>")
      
    # end

    # test "add labels" do

    #   @a.name="j"
    #   @a.content = "test" + "a".variable + "b".variable
    #   @a.pressDefault
    #   i1 = "a".varIs" first"
    #   i2 = "b".varIs",but..."
    #   ans = @a.pressInsertEach(i1,i2)
    #   assert_equal(ans, "<j>test first,but...</j>")
  
    # end
    
    
 # func test_A_href()  {
 #        let a = A()
 #        a.href(_href: "http://www")
 #        XCTAssertEqual(a.press(), "<a href=\"http://www\"></a>")
        
 #    }
    
 #    func test_A_targe(){
 #        let a = A()
 #        a.target(_target: "http://www")
 #        XCTAssertEqual(a.press(), "<a target=\"http://www\"></a>")
        
 #    }
    
 #    func test_A_href_targe(){
 #        let a = A()
 #        a.href(_href: "http://www")
 #        a.target(_target: "http://www")
 #        XCTAssertEqual(a.press(), "<a href=\"http://www\" target=\"http://www\"></a>")
        
 #    }

    
    
  end
end
