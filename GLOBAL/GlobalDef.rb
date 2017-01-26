#!/usr/bin/env ruby

# String extension ############
class String
  def >>(other)
      self + other + other
  end
end


# global constant ############

  RET = "\n"
  TAB = "\t"
  SPC             = " "
  COMMA           = ","
  COLON           = ":"
  SEMI_COLON      = ";"
  JS_CMD_END      = SEMI_COLON
  DOUBLE_QUO      = "\""
  SINGLE_QUO      = "'"
  EQUAL           = "="

  INSERTSTRING        = "%%"
  STYLE_CONTENT       = "##STYLE##"
  LABEL_INSERT_START  = "##LABELSTART##"
  LABEL_INSERT_END    = "##LABELEND##"

# Table ####################
  BLA      = "<br>"
  ROW_SPAN = "%rowSpan="
  COL_SPAN = "%colSpan="


# Struct ####################

  InsertData = Struct.new(:label, :data)



__END__



//１行ごとに文字列を抜き出す
func enumerateLine (target:String) -> [String] {
    var l: [String] = []
    target.enumerateLines{
        line, stop in
        
        //下記に１行ごとに行いたい動作を記述
        l.append(line)
        print("\(line)")
    }
    return l
}


extension String { // variable in html
    var variable: String {
        return LABEL_INSERT_START + self + LABEL_INSERT_END
    }
    
    func ins (data:String) -> (label:String, data:String){
        return (self,data)
    }
}

// - extention
extension String {// dot connect
    func dott (nex: String) -> String {
        return self + "." + nex
    }
    
    func inParenth (inn: String) -> String {
        return self + "(" + SINGLE_QUO + inn + SINGLE_QUO + ")"
    }
    
    func inDoubleQuo (inn : String) -> String {
        return self +  DOUBLE_QUO + inn + DOUBLE_QUO
    }
    
    func inSingleQuo (inn : String) -> String {
        return self +  SINGLE_QUO + inn + SINGLE_QUO
    }
}

extension String { // 一行ずつに分割
    
    var lines: [String] {
        var lines = [String]()
        self.enumerateLines { (line, stop) -> () in
            lines.append(line)
        }
        return lines
    }
    
}

//http://qiita.com/ha_g1/items/d41febac011df4601544
extension String {
    //絵文字など(2文字分)も含めた文字数を返します
    var count: Int {
        let string_NS = self as NSString
        return string_NS.length
    }
    
    //正規表現の検索をします
    func pregMatche(pattern: String, options: NSRegularExpression.Options = []) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else {
            return false
        }
        let matches = regex.matches(in: self, options: [], range: NSMakeRange(0, self.count))
        return matches.count > 0
    }
    
    //正規表現の検索結果を利用できます
    func pregMatche(pattern: String, options: NSRegularExpression.Options = [], matches: inout [String]) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else {
            return false
        }
        let targetStringRange = NSRange(location: 0, length: self.count)
        let results = regex.matches(in: self, options: [], range: targetStringRange)
        for i in 0 ..< results.count {
            for j in 0 ..< results[i].numberOfRanges {
                let range = results[i].rangeAt(j)
                matches.append((self as NSString).substring(with: range))
            }
        }
        return results.count > 0
    }
    
    //正規表現の置換をします
    func pregReplace(pattern: String, with: String, options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, self.count), withTemplate: with)
    }
}
