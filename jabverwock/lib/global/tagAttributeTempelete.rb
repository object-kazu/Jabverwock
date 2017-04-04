if $FOR_GEM
  require "global/globalDef"
else
  require_relative "globalDef"
end


module Jabverwock
  using StringExtension
  using SymbolExtension
  using ArrayExtension
  
  class TagAttributeTemplete
    class << self

      # indexと項目名の対応を保持, 1 => store_id
      # クラスにアクセッサが定義される
      # CssAttrTemplate.index_to_attr にアクセスできる
      attr_accessor :index_to_attr 

      def define_attributes(attributes)
        @index_to_attr ||= {}

        attributes.each_with_index do |attr, index|
          attr_accessor attr # attrへのアクセッサ
          @index_to_attr[index] = attr # indexと項目名の対応

          # method chain
          # ex) method_a(1).method_b(2)
          # define_method "#{attr}"do |v|
          #   eval "@#{attr} = v"
          #   self
          # end
          
          #add_attr
          define_method "add_#{attr}" do |val| 
            eval "@#{attr} = val"
            self.send(:templeteAdd, "#{attr}", val)
          end
          
        end
      end
    end
    
    
    EmptyStr = ""
    attr_accessor :aString

    def initialize   
      @aString = String.new

      self.class.index_to_attr.each_with_index do |value, index|
        attr = self.class.index_to_attr[index] # クラスメソッドの `index_to_attr` で読込
        self.send("#{attr}=", EmptyStr) # 動的ディスパッチ
      end  
    end


    def insertSPace(target)
      if @aString.empty?
        KString.isString?(@aString)
        @aString += target
      else
        @aString += $SPC + target
      end

      self
    end
    
    
    def templeteAdd (index, val)
      
      # KString.isString?(index)
      # KString.isString?(val)

      # exchange, cls => class
      if index == "cls"
        index = "class"
      end

      if index.include?("_")
        index = index.gsub(/_/, "-")
      end
      
      src = index + "=".inDoubleQuot(val)
      unless val.empty?
        insertSPace(src)
      end

    end

  end

  # class Test < TagAttributeTemplete
  #   self.define_attributes [:tt,:id, :cls]
  # end
  
  # p a = Test.new
  # a.add_id("fs").add_cls("ww")

  # p a.cls
  
  
end



