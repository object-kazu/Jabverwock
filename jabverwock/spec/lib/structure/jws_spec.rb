require 'spec_helper'
require_relative '../../lib/paths'

using StringExtension

module Jabverwock

  using StringExtension

  RSpec.describe 'jw basic test' do
    subject(:jws) { JWS.new }    
    it 'is test for global' do
      expect(jws.name).to eq 'jws' 
    end    
  end

  RSpec.describe 'insert variable' do
    # subject(:jws){JWS.new}
    
    it 'countArrayDepth 'do
      arr =
        ["a",
         "b",
         ["aa",
          "bb"],
         ["cc",
          "cdd"],
         "c"
        ]

      ans = JWS.countArrayDepth arr
      expect(ans[0]).to eq :index0 => "a"
    end

    it 'countArrayDepth with P tag' do
      p1 = P.new.contentIs "this is test1"
      p2 = P.new.contentIs "this is test2"
      arr =
        [
          p1,
          p2
          
        ]

      ans = JWS.countArrayDepth arr
      expect(ans[0]).to eq :index0 => p1
    end

    it 'countArrayDepth with HTML and P tag' do
      html = HTML.new
      p1 = P.new.contentIs "this is test1"
      arr =
        [
          html,
          [p1]
          
        ]

      ans = JWS.countArrayDepth arr
      expect(ans[0]).to eq :index0 => html
      expect(ans[1]).to eq :index1 => p1
    end

    it 'countArrayDepth with head, title and body  tag' do
      header = HEADER.new
      title = TITLE.new.contentIs "this is test1"
      body = BODY.new
      arr =
        [
          header,
          [title],
          body
          
        ]

      ans = JWS.countArrayDepth arr
      expect(ans[0]).to eq :index0 => header
      expect(ans[1]).to eq :index1 => title
      expect(ans[2]).to eq :index0 => body
    end

    
    it 'is a JW class' do
      p1 = P.new.contentIs "this is test1"
      ans = JWS.transrate p1
      expect(ans).to eq "<p>this is test1</p>"
    end

    it 'is not a JW class' do
      ans = JWS.transrate "a"
      expect(ans).to eq "a"
    end


    it 'addTab' do
      test = "test"
      ans = JWS.addTab test, 1
      expect(ans).to eq "\ttest"
    end

    it 'extractTabNumber' do
      num = JWS.extractTabNumber :index1
      expect(num).to eq 1
    end
    
    it 'extractTabNumber' do
      num = JWS.extractTabNumber :index0
      expect(num).to eq 0
    end


    it 'transrate case 1'do
      p1 = P.new.contentIs "test"
      ans = JWS.transrate p1,1
      expect(ans).to eq "\t<p>test</p>"
      
    end

    it 'transrate case 2' do
      body = BODY.new.contentIs "test"
      ans = JWS.transrate body,1
      expect(ans).to eq "\t<body>\n\ttest\n\t</body>"
      
    end

    
    # it 'tabbing' do
    #   tes = {:index1 => "body"}
    #   ans = JWS.tabbing tes
    #   expect(ans).to eq "\tbody"
    # end
    
    # it 'tabbing case 2' do
    #   tes = {:index1 => "body",:index0 => "footer"}
    #   ans = JWS.tabbing tes
    #   expect(ans).to eq "\tbody\nfooter"
    # end

    # it 'tabbing case 3' do
    #   p1 = P.new.contentIs "test"
    #   tes = {:index1 => p1.tgStr}
    #   ans = JWS.tabbing tes
    #   expect(ans).to eq "\t<p>test</p>"
    # end
    # it 'build case 1' do
    #   p1 = P.new.contentIs "test"
    #   ans = JWS.build [p1]
    #   expect(ans).to eq "<p>test</p>"
      
    # end
    
    # it 'tabbing case 4' do
    #   body = BODY.new.contentIs "test"
    #   tes = {:index1 => body}
    #   ans = JWS.tabbing tes
    #   expect(ans).to eq "\t<body>\n\t\ttest\t</body>"
    # end

    
    # it 'build' do
    #   header = HEADER.new
    #   title = TITLE.new.contentIs "this is test1"
    #   arr =
    #     [
    #       header,
    #       [title],
    #     ]
    #   ans = JWS.build arr
    #   expect(ans).to eq "<header>\t<title>\t\tthis is test1\t</title></header>"
    # end

        
  end
  
end   

