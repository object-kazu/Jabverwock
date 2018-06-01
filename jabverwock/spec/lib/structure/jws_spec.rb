# require 'spec_helper'
# require_relative '../../lib/paths'

# using StringExtension

# module Jabverwock

#   using StringExtension

#   RSpec.describe 'jw basic test' do
#     subject(:jws) { JWS.new }
#     # it 'is test for global' do
#     #   expect(jws.name).to eq 'jws' 
#     # end    
#   end
  
#   RSpec.describe 'add members' do
#     # it 'form, [a,b]' do
#     #   h = HEAD.new
#     #   b = P.new
#     #   a = JWS.build [h,b]
#     #   ans = "<head>\n</head>\n<p></p>"
#     #   expect(a.tgStr).to eq ans
#     # end
#   end
  
#   RSpec.describe 'add child' do
#     # it 'form, [a,[b]]' do
#     #   h = HEAD.new
#     #   b = P.new
#     #   a = JWS.build [h,[b]]
#     #   ans = "<head>\n<p></p>\n</head>"
#     #   expect(a.tgStr).to eq ans
#     # end

#     it 'form, [a,[b,[c]]]' do
#       h = HEAD.new
#       b = P.new($MT)
#       d = DIV.new
#       a = JWS.build [h,[b,[d]]]
#       ans = "<head>\n<p>\n<div>\n</div>\n</p>\n</head>"
#       expect(a.tgStr).to eq ans
#     end

#   end

  
  
#   RSpec.describe 'insert variable' do

#     # it "test temp code" do
      
#     #   head = HEAD.new
#     #   p1 = P.new.contentIs "test"
#     #   p1.css.background_color("good")
#     #   a = JWS.build [head,[p1]]
#     #   ans = "<head>\n<p>test</p>\n<style>\np {\nbackground-color: good;\n}\n</style>\n</head>"
#     #   expect(a.tgStr).to eq ans 
#     # end

#     # it "test build code 2" do
      
#     #   head = HEAD.new
#     #   p1 = P.new.contentIs "test"
#     #   p1.css.background_color("good")
#     #   a = JWS.build [head,p1]
#     #   ans = "<head>\n<style>\np {\nbackground-color: good;\n}\n</style>\n</head>\n<p>test</p>\n"
#     #   expect(a.tgStr).to eq ans 
#     # end

#     # it "test build code " do
      
#     #   head = HEAD.new
#     #   p1 = P.new.contentIs "test"
#     #   p1.css.background_color("good")
#     #   div = DIV.new
      
#     #   a = JWS.build [head,div,[p1]]
#     #   ans = "<head>\n<style>\np {\nbackground-color: good;\n}\n</style>\n</head>\n<div>\n<p>test</p>\n</div>\n"
#     #   expect(a.tgStr).to eq ans 
#     # end

#     # it "test build code case 2 " do
      
#     #   head = HEAD.new
#     #   p1 = P.new.contentIs "test"
#     #   p1.css.background_color("good")
#     #   div = DIV.new
      
#     #   a = JWS.build [head,[div,[p1]]]
#     #   # ans = "<head>\n<div>\n<p>test</p>\n</div>\n<style>\np {\nbackground-color: good;\n}\n</style>\n</head>\n"
#     #   # expect(a.tgStr).to eq ans 
#     # end

    
# #     it "test build code 2 " do
# #       b = JK.body
# #       h = JK.html

# #       pp = JK.p.contentIs "test"
      
      
# #       ans = JWS.temp(h,b)
# #       p h.tgStr
# #       # aa = JWS.build [h,
# #       #                  [b,
# #       #                   [pp]
# #       #                  ]
# #       #                 ]
      
# #       ans = "<html>\n<body>\n<p>test</p>\n</body>\n</html>"
      
# #       # pass the test
# #       # b.addChild pp
# #       # h.addChild b
# #       # expect(h.tgStr).to eq ans 

# # #      expect(aa.tgStr).to eq ans 
# #     end

#     # it "test" do

#     #   b = JK.body
#     #   h = JK.html

#     #   pp = JK.p.contentIs "test"
      
      
#     #   aa = JWS.tempbuilder [h,
#     #                         [b,
#     #                          [pp]
#     #                         ]
#     #                        ]
#     #   p aa
#     # end
    
#   end  
# end   

