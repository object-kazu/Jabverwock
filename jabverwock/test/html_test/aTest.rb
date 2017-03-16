require 'test/unit'
#require "global/jwSingle"

require '../../lib/global/jwSingle'

module Jabverwock
  using StringExtension
  using SymbolExtension
  
  
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

    test "A tag" do
      ans = @a.pressDefault
      assert_equal(ans, "<a></a>")
    end
    
    
    test "a css" do
      
      j1 = A.new
      j1.css.color("red").font_size(10)
      assert_equal(j1.showCssString, "a {\n\tcolor: red;\n\tfont-size: 10;\n}")     
    end

    
    test "content add" do
      
      @a.content = "test"
      ans = @a.pressDefault
      ans2 = @a.pressVal.showTempleteString
      
      assert_equal(ans, "<a>test</a>")
      assert_equal(ans, ans2)
    end
    
    
    test "add label case 1" do

      @a.content = "test" + "a".variable
      ans = @a.pressDefault
      ans2 = @a.pressVal.showTempleteString
      
      assert_equal(ans, "<a>test</a>")
      assert_not_equal(ans, ans2)
      
    #     // not equal <j>testLABEL_INSERT_START + "a" + LABEL_INSERT_END</j>
    #     // because at press method , remove LABEL_INSERT_START + "a" + LABEL_INSERT_END
      
    end


    test "add symble label case 1" do

      @a.content = "test" + :a.variable
      ans = @a.pressDefault
      ans2 = @a.pressVal.showTempleteString
      
      assert_equal(ans, "<a>test</a>")
      assert_not_equal(ans, ans2)
      
    #     // not equal <j>testLABEL_INSERT_START + "a" + LABEL_INSERT_END</j>
    #     // because at press method , remove LABEL_INSERT_START + "a" + LABEL_INSERT_END
      
    end

    
    test "add label case 2" do

      @a.content = "test" + "a".variable
      @a.pressDefault
      ans = @a.pressInsert("a".varIs" is done")
      assert_equal(ans, "<a>test is done</a>")

    end

    test "add symble label case 2-1" do

      @a.content = "test" + :a.variable # -> symble
      @a.pressDefault
      ans = @a.pressInsert("a".varIs" is done") # -> string
      assert_equal(ans, "<a>test is done</a>")

    end
    
    test "add symble label case 2-2" do

      @a.content = "test" + :a.variable # -> symble
      @a.pressDefault
      ans = @a.pressInsert(:a.varIs " is done") # -> symble
      assert_equal(ans, "<a>test is done</a>")

    end
    test "add symble label case 2-3" do

      @a.content = "test" + "a".variable # -> string
      @a.pressDefault
      ans = @a.pressInsert(:a.varIs " is done") # -> symble
      assert_equal(ans, "<a>test is done</a>")

    end

    
    test "add label case 3" do

      @a.content = "test" + "a".variable + "-> yes!"
      @a.pressDefault
      ans = @a.pressInsert("a".varIs" is done")
      assert_equal(ans, "<a>test is done-> yes!</a>")
      
    end
    
    test "add label case 4, retry insert data" do
 
      @a.content = "test" + "a".variable + "-> yes!"
      @a.pressDefault
      ans = @a.pressInsert("a".varIs" is done")
      assert_equal(ans, "<a>test is done-> yes!</a>")

      #retry
      ans2 = @a.pressInsert("a".varIs" was success!")
      assert_equal(ans2, "<a>test was success!-> yes!</a>")
      
    end

    test "add label case 5, no pressDefault" do
 
      @a.content = "test" + "a".variable + "-> yes!"
      ans = @a.pressInsert("a".varIs" is done")
      assert_equal(ans, "<a>test is done-> yes!</a>")

      #retry
      ans2 = @a.pressInsert("a".varIs" was success!")
      assert_equal(ans2, "<a>test was success!-> yes!</a>")
      
    end

    
    test "add labels" do

      @a.content = "test" + "a".variable + "b".variable
      @a.pressDefault
      i1 = "a".varIs" first"
      i2 = "b".varIs",but..."
      ans = @a.pressInsertEach(i1,i2)
      assert_equal(ans, "<a>test first,but...</a>")
  
    end
    
    test "href add" do
      @a.tagManager .tagAttr(:href, "http://www")
      ans = @a.pressDefault
      assert_equal(ans,"<a href=\"http://www\"></a>")
      
    end

    test "href add improved" do
      @a.attr(:href, "http://www")
      ans = @a.pressDefault
      assert_equal(ans,"<a href=\"http://www\"></a>")
      
    end

    test "attr chain" do
      @a.attr(:href, "http://www").attr(:id,"test")
      ans = @a.pressDefault
      assert_equal(ans,"<a href=\"http://www\" id=\"test\"></a>")
      
    end

    test "attr target" do
      @a.attr(:target,"http://www")
      ans = @a.pressDefault
     
      assert_equal(ans,"<a target=\"http://www\"></a>" )

    end
    
    
    
  end
end
