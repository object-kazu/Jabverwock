require_relative "propertyTemplete"

module Jabverwock
  class Font < CssAttrTemplate
    
    self.define_attributes [:font, :font_style, :font_variant,:font_weight, :font_size, :font_family, :font_size_adjust, :font_stretch]
    
    # font …… フォントに関する指定をまとめて行う
    # font-style …… フォントをイタリック体・斜体にする
    # font-variant …… フォントをスモールキャップにする
    # font-weight …… フォントの太さを指定する
    # font-size …… フォントのサイズを指定する
    # font-family …… フォントの種類を指定する
    # font-size-adjust …… フォントのサイズを調整する
    # font-stretch …… フォントを縦長・横長にする
    
  end  

  
end


