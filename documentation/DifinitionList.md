# class
## DL
`<dl> </dl>`

## DT
`<dt></dt>`

## DD
`<dd></dd>`

 ```ruby
  def self.dtdd(title, desc)
    dt = DT.new.contentIs title
    dd = DD.new.contentIs desc    
    dt.addMember dd    
    dt
  end
  
  def self.dfList
    dl = DL.new
    d1 = self.dtdd("car", "car is car")
    d2 = self.dtdd("train", "train is train")
    d3 = self.dtdd("ship", "ship is ship")
    dl.addChildren d1, d2, d3
    dl
  end
  
  def self.bodier
    body = BODY.new
    body.addChild dfList
    body
  end
  
  html.addChild bodier

 ```
>[result]
>>```
>><html>
>>	<body>
>>		<dl>
>>			<dt>car</dt>
>>			<dd>car is car</dd>
>>			
>>			<dt>train</dt>
>>			<dd>train is train</dd>
>>			
>>			<dt>ship</dt>
>>			<dd>ship is ship</dd>
>>			
>>		</dl>
>>	</body>
>></html>
>>```
