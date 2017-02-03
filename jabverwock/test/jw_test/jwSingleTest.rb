require 'test/unit' 
require '../../lib/global/jwSingle'
require '../../lib/global/insertData'


module Jabverwock
  using StringExtension
  class JwSingleTest < Test::Unit::TestCase
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

    test "JWSingle first test" do
      tm = JWSingle.new
      tm.setName = "p"
      ans = tm.pressDefault
      assert_equal(ans, "<p></p>")

    end
    
    test "addcontentAt"do
      t = JWSingle.new
      i = InsertData.new(label: "news", data: "at")
      ans =t.addContentAt(i)
      assert_equal(ans, $LABEL_INSERT_START + "news" + $LABEL_INSERT_END + "at")
    end

    test "content add" do
      t = JWSingle.new
      t.setName="j"
      t.content = "test"
      ans = t.pressDefault
      assert_equal(ans, "<j>test</j>")
    end

    test "add label case 1" do
      t = JWSingle.new
      t.setName="j"
      t.content = "test" + "a".variable
      ans = t.pressDefault
      assert_equal(ans, "<j>test</j>")
      
    #     // not equal <j>testLABEL_INSERT_START + "a" + LABEL_INSERT_END</j>
    #     // because at press method , remove LABEL_INSERT_START + "a" + LABEL_INSERT_END
      
    end
    
    ### koko now
    
    # test "add label case 2" do
    #   t = JWSingle.new
    #   t.setName="j"
    #   t.content = "test" + "a".variable
    #   t.pressDefault
    #   ans = t.pressInsert_A()
    #   assert_equal(ans, "<j>test</j>")

    # end
    
    # func test_label_case2 (){
    #     let j = JWSingle()
    #     j.setName(name: "j")
    #     j.content = "test" + "a".variable
    #     let fAns = j.press()
       
    #     XCTAssertEqual(fAns, "<j>test</j>")

    #     let sAns = j.insertPress(_data_: ["a".ins(data: " is done")])
    #     XCTAssertEqual(sAns, "<j>test is done</j>")
        
    # }

    # func test_label_case2_Dash (){
    #     let j = JWSingle()
    #     j.setName(name: "j")
    #     j.content = "test" + "a".variable
    #     let fAns = j.press()
    #     XCTAssertEqual(fAns, "<j>test</j>")
    
    #     let sAns = j.insertPress(_data_: [("a", " is done")])
    #     XCTAssertEqual(sAns, "<j>test is done</j>")
        
    # }

    # func test_label_case3 (){
    #     let j = JWSingle()
    #     j.setName(name: "j")
    #     j.content = "test" + "a".variable
    #     j.press()
        
    #     let sAns = j.insertPress(_data_: ["a".ins(data: " is done")])
    #     XCTAssertEqual(sAns, "<j>test is done</j>")

    #     let tAns = j.insertPress(_data_: ["a".ins(data: " is done new")])
    #     XCTAssertEqual(tAns, "<j>test is done new</j>")
        
    #     let x = "a".ins(data: " was changed")
    #     let uAns = j.insertPress(_data_: [x])
    #     XCTAssertEqual(uAns, "<j>test was changed</j>")
        
    # }

    
    
  end
end
