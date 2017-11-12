# Class

## OL
`<ol></ol>`

 ```ruby
  def self.orderedList
    item = %w(item1 item2)
    item.inject([]){ |arr,i|
      t = OL.new.contentIs i
      arr << t      
    }
  end
  
  def self.bodier
    body = BODY.new
    body.addChildren orderedList
    body
  end
  
  html = HTML.new
  html.addChild bodier

 ```
>[result]
>>```
>><html>
>>	<body>
>>		<ol>
>>			item1
>>		</ol>
>>		<ol>
>>			item2
>>		</ol>
>>	</body>
>></html>
>>```


## LI
`<li></li>`

 ```ruby

  def self.lists
    item = %w(item1 item2)
    ol = OL.new
    item.each do |i| 
      t = LI.new.contentIs i
      ol.addChild t
    end
    ol
  end

  def self.bodier
    body = BODY.new
    body.addChild lists
    body
  end
  
  html = HTML.new
  html.addChild bodier

 ```
>[result]
>>```
>><html>
>>    <body>
>>	   <ol>
>>	    <li>item1</li>
>>	    <li>item2</li>
>>	   </ol>	
>>    </body>
>></html>
>>```

## LI_Multi
li_multi express list with multi line element.

`<li>\n</li>`

 ```ruby
  def self.itemList (item)
    arr = []
    unless item.is_a? Array
      l = LI.new.contentIs item
      arr.append l
      return arr
    end
    
    if item.count > 0
      item.each do |i|
        l = LI.new.contentIs i     
        arr.append l 
      end
    end

    arr
  end
  
  def self.mList(title, *items)
    lm = LI_multi.new.contentIs title
    ul = UL.new
    l1 = itemList items
    ul.addChildren l1
    lm.addChild ul
    lm    
  end
  
  def self.orderList()
    o = OL.new
    ml = mList("Food", "a","b","c")
    mm = mList("Toy","1","2","3")
    o.addChildren [ml, mm]
    o
  end
  
  def self.bodier
    body = BODY.new
    body.addChild orderList
    body
  end
  
  html.addChild bodier

 ```
>[result]
>>```
>><html>
>>	<body>
>>		<ol>
>>			<li>
>>				Food
>>				<ul>
>>					<li>a</li>
>>					<li>b</li>
>>					<li>c</li>
>>				</ul>
>>			</li>
>>			<li>
>>				Toy
>>				<ul>
>>					<li>1</li>
>>					<li>2</li>
>>					<li>3</li>
>>				</ul>
>>			</li>
>>		</ol>
>>	</body>
>></html>
>>```



## UL
`<ul></ul>`

 ```ruby
  def self.lists
    item = %w(item1 item2)
    item.inject([]){ |arr,i|
      t = LI.new.contentIs i
      arr << t      
    }    
  end
  
  def self.unOrderList
    ol = UL.new.attr(:type__circle)
    ol.addChildren lists
    ol
  end

  def self.bodier
    body = BODY.new
    body.addChild unOrderList
    body
  end
  
  html = HTML.new
  html.addChild bodier

 ```
>[result]
>>```
>><html>
>>	<body>
>>		<ul type="circle">
>>			<li>item1</li>
>>			<li>item2</li>
>>		</ul>
>>	</body>
>></html>
>>```
