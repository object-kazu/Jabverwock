# method
## caption (str)
*__str__* : string, set table caption

## headerList (arr)
*__arr__* : array, add header list
 ```ruby
      t = JWTable.new
      t.caption "test"
      t.headerList ["name","address","tel"]
 ```
>[result]
>>```
>><table>
>>    <caption>test</caption>
>>    <tr>\n<th></th><th>name</th><th>address</th><th>tel</th>\n</tr>
>></table>
>>```

## addRows (arr)
*__arr__* : array, add row data

ex 1)
 ```ruby
	t = JWTable.new
	t.caption "test"
	t.addRows ["line1", "shi", "tokyo", "03000000"]
     
 ```
>[result]
>>```
>><table>
>>    <caption>test</caption>
>>    <tr>\n<td>line1</td><td>shi</td><td>tokyo</td><td>03000000</td>\n</tr>
>></table>
>>```


ex 2)
 ```ruby
  def self.iTable
    t = JWTable.new.attr(:border, "1px")
    
    a1 = ["row1 cell1", "row1 cell2" ]
    a2 = ["row2 cell1", "row2 cell2" ]
    a3 = ["row3 cell1", "row3 cell2" ]
    
    t.addRows a1, a2, a3
    t
  end
  
  def self.bodies
    body = BODY.new
    c = HEADING.new.contentIs "Hello table"
    body.addChildren c, iTable
    body
  end

  html= HTML.new
  html.addChild bodies

 ```
>[result]
>>```
>><html>
>>	<body>
>>		<h1>Hello table</h1>
>>		<table border="1px">
>>			<tr>
>>				<td>row1 cell1</td><td>row1 cell2</td>
>>			</tr>
>>			<tr>
>>				<td>row2 cell1</td><td>row2 cell2</td>
>>			</tr>
>>			<tr>
>>				<td>row3 cell1</td><td>row3 cell2</td>
>>			</tr>
>>		</table>
>>	</body>
>></html>
>>```

## rowSpan and colSpan
this is string class method  
usage: "test".rowSpan(2)

 ```ruby
    t = JWTable.new
	t.caption "test"
	hl = %w(name address tel)
            
	t.headerList hl
	t.addRows ["line1".rowSpan(2), "shi", "tokyo", "03000000"]
	t.addRows ["line2", "shi2", "tokyo2", "030000002"]   
 ```
>[result]
>>```
>><table>
>>	<caption>test</caption>
>>	<tr>\n<th></th><th>name</th><th>address</th><th>tel</th>\n</tr>
>>	<tr>\n<td rowspan=\"2\">line1</td><td>shi</td><td>tokyo</td><td>03000000</td>\n</tr>
>>	<tr>\n<td>line2</td><td>shi2</td><td>tokyo2</td><td>030000002</td>\n</tr>
>></table>
>>```
	
# class
## Table
Table class include several tags, such as caption, td, th, tr.


