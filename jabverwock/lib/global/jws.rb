# structDescript.rbを改良する
# Tab とRTで構造化する -> python like
# class method  とする
# jws{
# html
# \t header
# \t \t title
# \t body
# \t footer
#}

# ->
# <html>
#    <header>
#      <title></title>
#    </header>
#    <body>
#    </body>
#    <footer>
#    </footer>
# </html>

# 合成可能
# jws_header = jws{...}
# jws_body = jws{...}
# jws{
#   jws_header
# jws_body
# }
