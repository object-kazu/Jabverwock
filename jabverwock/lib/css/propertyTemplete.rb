module Jabverwock
  
  #http://masayuki14.hatenablog.com/entry/2016/04/28/122359
  
  #Css attribute managee
  class CssAttrTemplate
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
          define_method "#{attr}"do |v|
            eval "@#{attr} = v"
            self
          end
        end
      end
    end
    
    attr_accessor :name
    EmptyStr = ""
    
    def initialize(name)
      nameWithSelectors name

      
      self.class.index_to_attr.each_with_index do |value, index|
        attr = self.class.index_to_attr[index] # クラスメソッドの `index_to_attr` で読込
        self.send("#{attr}=", EmptyStr) # 動的ディスパッチ!!
      end  
    end

    <<-MEMO_NAME
       - nameWithSelectorsの役割

        a = Test.new(:id__test)
        p a.name# => "#test"

        b = Test.new(:cls__test)
        p b.name# => ".test"

        c = Test.new("ss")
        p c.name# => "ss"
    
    MEMO_NAME
    def nameWithSelectors(name)
      @name = name.to_s
      
      if @name.include?("id__")
        @name = "##{@name.split("id__").last}"
      end

      if @name.include?("cls__")
        @name = ".#{@name.split("cls__").last}"
      end
      
    end
    
    # エクスポート
    def pStr # vars + vals
      return "" if vars.count == 0
      varsAddVals.join("\n")
    end

    def varsAddVals # vars + vals
      result = []
      vars.each_with_index{ |v , index|
        next if vals[index] == EmptyStr
        result << "%s: %s;" % [v,vals[index]]
      }
      result
    end

    
    # format of property is difference
    # ex)
    # font: "Helvetica" => "" 
    # font-size: 12px   => no ""    
    
    private
    def vars
      instance_variables.inject([])do |result,var|
        k = var.to_s.tr('@','')
        k.gsub!(/_/, "-")
        
        result << "%s" % [k]        
      end
    end

    def vals
       result = []
       instance_variables.each { |var|
         v = instance_variable_get(var)
         result << "%s" % [v]
       }
       result
    end
    
  end

# class Sam < CssAttrTemplate
#   self.define_attributes [:pp, :dd]
# end
# p a = Sam.new("s")
# a.pp = 10
# p a.pStr
# p a.pp(1).dd(2)
# p a.dd(1).pp(:red)

end
