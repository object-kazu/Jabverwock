require 'test/unit' 
require '../../GLOBAL/GlobalDef' 
require '../../GLOBAL/TagAttribute'# => LoadError: cannot load such file -- ./GlobalDef


class TagAttributeTest < Test::Unit::TestCase
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
  
  # test "TagAttribute, path confirm " do
  #   tm =  TagAttribute.new() 
  #   tm.addLang("jp")

  #   assert_equal(tm.aString, "lang=\"jp\"")
    
  # end  

  
end

# ~> LoadError
# ~> cannot load such file -- ./GlobalDef
# ~>
# ~> /Users/shimizukazuyuki/.rbenv/versions/2.4.0/lib/ruby/2.4.0/rubygems/core_ext/kernel_require.rb:55:in `require'
# ~> /Users/shimizukazuyuki/.rbenv/versions/2.4.0/lib/ruby/2.4.0/rubygems/core_ext/kernel_require.rb:55:in `require'
# ~> /Users/shimizukazuyuki/ActiveProject/JabberWockProjects/JabverwockRuby/GLOBAL/TagAttribute.rb:1:in `<top (required)>'
# ~> /Users/shimizukazuyuki/.rbenv/versions/2.4.0/lib/ruby/2.4.0/rubygems/core_ext/kernel_require.rb:55:in `require'
# ~> /Users/shimizukazuyuki/.rbenv/versions/2.4.0/lib/ruby/2.4.0/rubygems/core_ext/kernel_require.rb:55:in `require'
# ~> /var/folders/w8/tp2v81_s3f3g44st06_hgy0c0000gn/T/seeing_is_believing_temp_dir20170126-95120-ct89sv/program.rb:3:in `<main>'

