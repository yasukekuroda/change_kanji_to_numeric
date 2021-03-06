# =======================================================
# "七千百二十三"といった、漢数字による 1~9999の数の表現を、
# 7123 のような数値に変換するプログラム
# =======================================================

# 漢字 → 数字 へ変換するメソッド
def kan2num(input_str)

  digit4 = digit3 = digit2 = digit1 = "0" # 4桁分の変数
  str = input_str.dup # コピー

  # ハッシュの作成。 {key: value} の組み合わせはgsubで変換時に使用。
  # keyに該当する文字列をvalueに変換したいので、keyは文字列で定義したい。
  #hash = {"一": "1", "二": "2", "三": "3", "四": "4", "五": "5", "六": "6", "七": "7", "八": "8", "九": "9"} # => NG
  hash = {"一" => "1", "二" => "2", "三" => "3", "四" => "4", "五" => "5", "六" => "6", "七" => "7", "八" => "8", "九" => "9"}

  # 数字部分を変換(破壊的)。"七千八百二十三" → "7千8百2十3"
  str.gsub!(Regexp.union(hash.keys), hash)

  # "千", "百", "十"といった単位部分を変換
  if str =~ /^((\d)?千)?((\d)?百)?((\d)?十)?(\d)?$/
    # print "  $1:", $1, "  $2:", $2, "  $3:", $3, "  $4:", $4, "  $5:", $5, "  $6:", $6, "  $7:", $7, "\n"
    digit4 = $2 || "1" if $1 #入力が "/千.+/" のとき、最上位桁は"1"と出力したい
    digit3 = $4 || "1" if $3
    digit2 = $6 || "1" if $5
    digit1 = $7 || "0"
  end
  return (digit4 + digit3 + digit2 + digit1).to_i
end

p kan2num("七千八百二十三") # 7823
p kan2num("千八百二十三") # 1823
p kan2num("八百二十三") # 823
p kan2num("百二十三") # 123
p kan2num("百三") # 103
p kan2num("二十三") # 23
p kan2num("十三") # 13
p kan2num("三") # 3
