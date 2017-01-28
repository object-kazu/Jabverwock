
module Jabverwock  
  class Press
    
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

    def insertData(data)
      
    end
    
    #  func insertData (_data_: [(label:String, data :String)]) {
    #      for d in _data_ {
    #          insertData(label: d.label, Data: d.data)
    #      }
    #  }
    
    #  func insertData (label: String, Data :String) {
    #      let targetString = label.variable
    #      let dataPlusTargetString = targetString + Data
    #      resultString = resultString.replacingOccurrences(of: targetString, with: dataPlusTargetString)
    #  }
    
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

