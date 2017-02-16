require 'test/unit' 
require '../../lib/global/jwSingle'

module Jabverwock
  using StringExtension
  
  class BTest < Test::Unit::TestCase
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
      @b = B.new
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
      a = B.new
      assert_equal(a.name , "b")
    end

    test "B tag" do
      ans = @b.pressDefault
      assert_equal(ans, "<b></b>")
    end
    
    
    test "b css" do
      
      j1 = B.new
      j1.css.color("red").font_size(10)
      assert_equal(j1.showCssString, "b {\ncolor: red;\nfont-size: 10;\n}")     
    end

    
    test "content add" do
      
      @b.content = "test"
      ans = @b.pressDefault
      ans2 = @b.pressVal.showTempleteString
      
      assert_equal(ans, "<b>test</b>")
      assert_equal(ans, ans2)
    end
    
    
    test "add label case 1" do

      @b.content = "test" + "a".variable
      ans = @b.pressDefault
      ans2 = @b.pressVal.showTempleteString
      
      assert_equal(ans, "<b>test</b>")
      assert_not_equal(ans, ans2)
      
    #     // not equal <j>testLABEL_INSERT_START + "a" + LABEL_INSERT_END</j>
    #     // because at press method , remove LABEL_INSERT_START + "a" + LABEL_INSERT_END
      
    end

    
    test "add label case 2" do

      @b.content = "test" + "a".variable
      @b.pressDefault
      ans = @b.pressAInsert("a".varIs" is done")
      assert_equal(ans, "<b>test is done</b>")

    end
    
    test "add label case 3" do

      @b.content = "test" + "a".variable + "-> yes!"
      @b.pressDefault
      ans = @b.pressAInsert("a".varIs" is done")
      assert_equal(ans, "<b>test is done-> yes!</b>")
      
    end
    
    test "add label case 4, retry insert data" do
 
      @b.content = "test" + "a".variable + "-> yes!"
      @b.pressDefault
      ans = @b.pressAInsert("a".varIs" is done")
      assert_equal(ans, "<b>test is done-> yes!</b>")

      #retry
      ans2 = @b.pressAInsert("a".varIs" was success!")
      assert_equal(ans2, "<b>test was success!-> yes!</b>")
      
    end

    test "add labels" do

      @b.content = "test" + "a".variable + "b".variable
      @b.pressDefault
      i1 = "a".varIs" first"
      i2 = "b".varIs",but..."
      ans = @b.pressInsertEach(i1,i2)
      assert_equal(ans, "<b>test first,but...</b>")
  
    end
    
    test "href add" do
      @b.tagManager .tagAttr(:href, "http://www")
      ans = @b.pressDefault
      assert_equal(ans,"<b href=\"http://www\"></b>")
      
    end

    test "href add improved" do
      @b.attr(:href, "http://www")
      ans = @b.pressDefault
      assert_equal(ans,"<b href=\"http://www\"></b>")
      
    end

    test "attr chain" do
      @b.attr(:href, "http://www").attr(:id,"test")
      ans = @b.pressDefault
      assert_equal(ans,"<b href=\"http://www\" id=\"test\"></b>")
      
    end

    test "attr target" do
      @b.attr(:target,"http://www")
      ans = @b.pressDefault
     
      assert_equal(ans,"<b target=\"http://www\"></b>" )

    end
    
  end
end
