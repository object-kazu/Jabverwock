

a = <<-SAM
<html>
<head>
<title>This is my first page</title>
<style type="text/css">
 #nav {
 border: 1px solid black;
 background-color: green;
 height: 50px;
 width : 200px;
 margin: 0px auto;
 }

 #nav ul {
 list-style-type:none;
 }

 #nav ul li{
 border : 1px solid red;
 display: inline;
 padding :3px;
 }

 #nav ul li a:link{
 text-decoration: none;
 }
 #nav ul li a:visited{
 text-decoration: none;
 color : blue;
 }
 #nav ul li a:hover{
 text-decoration: none;
 font-weight: bold; 
 }
 #nav ul li a:active{
 text-decoration: none;
 color: white;
 }
 
</style>
</head>
<body>
<div id="nav">
<ul>
<li><a href="index">Index</a></li>
<li><a href="contact">Contact</a></li>
<li><a href="Adress">Adress</a></li>
</ul>
</div>

<div id="selections">
<select>
<option value="red">Red</option>
<option value="blue">Blue</option>
<option value="white">White</option>
<option value="black">Black</option>
</select>
</div>

<div id="inputs">
<form method="POST" action="xxx.cgi">
<table>
<tr>
<td>名前：</td>
<td><input type=text name="namae"></td>
</tr>
<tr>
<td>パスワード：</td>
<td><input type=password name="passwd"></td>
</tr>
<tr>
<td>転送ファイル：</td>
<td><input type=file name="tensou"></td>
</tr>
<tr>
<td>性別：</td>
<td>
<input type=radio name="seibetsu" value="male" checked>男
<input type=radio name="seibetsu" value="female">女
</td>
</tr>
<tr>
<td>趣味：</td>
<td>
<input type=checkbox name="shumi" value="PC">パソコン
<input type=checkbox name="shumi" value="SP">スポーツ
<input type=checkbox name="shumi" value="RD">読書
</td>
</tr>
<tr>
<td></td>
<td>
<input type=submit value=" 送信 ">
<input type=reset value=" 取消 ">
</td>
</tr>
</table>
</form>
</div>
</body>
</html>
SAM




b = <<-RR
<a>
<b></b>
</a>

RR



