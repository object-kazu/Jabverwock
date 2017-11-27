Attributes provide additional information about HTML tag.

# set attribute
Attribute express by 'attr' method.

## attr (sym, str)  
*__sym__* : symbol, property (e.g. id, src, class ...)
*__str__* : string, value
 ```ruby
i1 = IMG.new.attr(:src ,"aaa")
a1 = A.new.contentIs("test a is done #{i1.tgStr} ?").withBreak

i2 = IMG.new.attr :src__bbb

 ```
>[result]
>>```
>><a>test a is done <img src="aaa"> ?</a><br>
>><img src="bbb">
>>```

## attr (*sym__str)
if str is simple, you can write as following,  
*__sym\_\_str__* : symbol connect str with double underscore '\_ \_'

 ```ruby

i3 = IMG.new.attr(:id__test, :src__ccc)

 ```
>[result]
>>```
>><img id="test" src="ccc">
>>```
