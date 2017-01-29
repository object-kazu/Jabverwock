
module Jabverwock  
  class Press
    attr_accessor :templeteString, :resultString
    
    
    def initialize
      # js

      # html & css
      @templeteString = "" #// Labelによる書き換え前のString
      @resultString = "" # // Labelによる書き換え後の最終String  
      
    end

    def initResutString
      @templeteString = ""
      @resultString = @templeteString
      
    end 

    def insertLabelData(label:, data:)
      targetString = label.variable
      dataPlusTargetString = targetString + data
      @resultString.gsub!(targetString, dataPlusTargetString)
    end
    
    def insertData(insertData)
      if !insertData.is_a?(InsertData)
        p "ahaaaa!, use InsertData class"
        raise RuntimeError
      end

      insertLabelData(label: insertData.label, data: insertData.data)
     
    end

    def insertDataList(*insertData)
      insertData.each do |d|
        insertData(d)
      end
    end
    
    
    
    #  func removeAllLabel () {
    #      let a = resultString.pregReplace(pattern: "##LABELSTART##.*?##LABELEND##", with: "")
    #      resultString = a
    #  }
    
    #  @discardableResult
    #  func withInsert(_data_: [(label:String, data :String)]) -> String {
    
    #      initResutString()
    #      insertData(_data_: _data_)
    #      removeAllLabel()
    #      core(name: EXPORT_TEST_File, dist: EXPORT_TEST_Dir)
    
    #      return resultString
    
    #  }
    
    #  @discardableResult
    #  func withInsert(label:String, data :String) -> String{
    #      initResutString()
    #      insertData(label: label, Data: data)
    #      removeAllLabel()
    #      core(name: EXPORT_TEST_File, dist: EXPORT_TEST_Dir)
    
    #      return resultString
    #  }
    
    #  // templateString -> resultString -> export
    #  @discardableResult
    #  func core(name: String, dist : String) -> String{
    #      exportResult(name: name, dist: dist)
    #      return resultString
    #  }
    
    #  func exportResult (name: String, dist : String) {
    
    #      // ドキュメントパス
    #      let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    #      // 保存するもの
    #      let fileObject = resultString
    #      // ファイル名
    #      var fileName = name
    #      // 保存する場所
    #      if !fileName.contains("/") {
    #          fileName = "/" + fileName
    #      }
    #      let filePath = documentsPath + fileName
    
    #      // 保存処理
    #      do {
    #          try fileObject.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
    #      } catch {
    #          print("Fail to write result at text file")
    
    #      }
    
    
    #      //file exist
    #      let fileManager = FileManager.default
    #      let path = dist + name
    
    #      if fileManager.fileExists(atPath: path){
    #          // remove file
    #          print("file remove!")
    #          removeFile(path: path)
    #      }
    
    #      // file move
    #      do{
    #          try fileManager.moveItem(atPath: filePath, toPath:path)
    #      } catch {
    #          assertionFailure("move error")
    #      }
    #  }
    
    #  func removeFile(path:String){
    #      let fileManager = FileManager.default
    
    #      do {
    #          try fileManager.removeItem(atPath: path)
    #          print("Removal successful")
    #      } catch let error {
    #          print("Error: \(error.localizedDescription)")
    #      }
    #  }

  end
end

