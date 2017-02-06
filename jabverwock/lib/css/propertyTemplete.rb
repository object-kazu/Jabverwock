module Jabverwock
  
  #http://masayuki14.hatenablog.com/entry/2016/04/28/122359
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
        end

      end
    end
    
    EmptyStr = ""
    def initialize()
      self.class.index_to_attr.each_with_index do |value, index|
        attr = self.class.index_to_attr[index] # クラスメソッドの `index_to_attr` で読込
        self.send("#{attr}=", EmptyStr) # 動的ディスパッチ!!
      end
    end

    def str
       result = []
       instance_variables.each { |var|
         k = var.to_s.tr('@','')
         v = instance_variable_get(var)
         next if v == EmptyStr
         result << "%s=\"%s\"" % [k,v]
       }
       result.join(', ')
    end
    
  end

# class Sam < CssAttrTemplate
#   self.define_attributes [:pp, :dd]
# end

# p a = Sam.new
# a.pp = 10
# p a.str

end
