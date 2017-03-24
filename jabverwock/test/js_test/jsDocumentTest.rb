require 'test/unit'

require '../../lib/global/globalDef'  
require '../../lib/js/jsDocument'

module Jabverwock
  using StringExtension
  using ArrayExtension
  
  class JsDocumentTest < Test::Unit::TestCase
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
      @jsd = JsDocument.new
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

    # test "jsDocument first test, for print debug " do
    #   p @jsd
    # end

    
    ### find element ###

    test "select by id" do
      @jsd.id = "test"
      assert_equal(@jsd.byID.element, "document.getElementById('test');")
    end
    
    test "select by class" do
      @jsd.updateSelector "id__koko", "cls__p"
      assert_equal(@jsd.byID.element, "document.getElementById('koko');")
      assert_equal(@jsd.byClassName.element, "document.getElementByClassName('p');")
    end
    test "select by class case 2" do
      @jsd.updateSelector :id__koko, :cls__p
      assert_equal(@jsd.byID.element, "document.getElementById('koko');")
      assert_equal(@jsd.byClassName.element, "document.getElementByClassName('p');")
    end
    
    test "select by TagName" do
      @jsd.updateSelector "id__koko","cls__p","name__popo"
      assert_equal(@jsd.byID.element, "document.getElementById('koko');")
      assert_equal(@jsd.byClassName.element, "document.getElementByClassName('p');")
      assert_equal(@jsd.byTagName.element, "document.getElementByTagName('popo');")
    end
    test "select by TagName case 2" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      assert_equal(@jsd.byID.element, "document.getElementById('koko');")
      assert_equal(@jsd.byClassName.element, "document.getElementByClassName('p');")
      assert_equal(@jsd.byTagName.element, "document.getElementByTagName('popo');")
    end
    
    
    # # ### add and delete element ###
    test "createElement" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = @jsd.createElement "koko"
      assert_equal(a, "document.createElement('koko');")

    end

    test "removeChild" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = @jsd.removeChild "aaa"
      assert_equal(a, "document.removeChild(aaa);")

    end

    test "removeChild case 2" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      aaa = Element.new
      a = @jsd.removeChild "#{aaa.element}"
      assert_equal(a, "document.removeChild();")

    end

    
    
    test "document write" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = @jsd.write "koko"
      assert_equal(a, "document.write('koko');")
    end

    
    
    # ### change element ###
    test "innerHTML" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = @jsd.byID.innerHTML "aaa"
      assert_equal(a, "document.getElementById('koko').innerHTML=\"aaa\";")
    end

    test "attribute" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = @jsd.byID.attribute "aaa"
      assert_equal(a, "document.getElementById('koko').attribute=\"aaa\";")
    end

    test "setAttribute" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = @jsd.byID.setAttribute("btn","red")
      assert_equal(a, "document.getElementById('koko').setAttribute(\"btn\",\"red\");")
    end

    test "style" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = @jsd.byID.style("backgroundColor", "red")
      assert_equal(a, "document.getElementById('koko').style.backgroundColor=\"red\";")
    end

    
    ### index ###
    test "index" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = @jsd.byID.index(0).innerHTML ("aaa")
      assert_equal(a,"document.getElementById('koko')[0].innerHTML=\"aaa\";")

      b = @jsd.byID.innerHTML ("bbb")
      assert_equal(b,"document.getElementById('koko').innerHTML=\"bbb\";")
      
    end

    test "index element" do
      @jsd.updateSelector :id__koko, :cls__p,:name__popo
      a = @jsd.byID.index(0).element
      assert_equal(a,"document.getElementById('koko')[0];")

    end


  end
end
