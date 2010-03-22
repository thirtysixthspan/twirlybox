class BaseCodec
  def self.base_n_decode(s, alphabets)
    n = alphabets.length
    rv = pos = 0
    charlist = s.split("").reverse
    charlist.each do |char|
      rv += alphabets.index(char) * n ** pos
      pos += 1
    end
    return rv
  end
  
  def self.base_n_encode(num, alphabets)
    n = alphabets.length
    rv = ""
    while num != 0
      rv = alphabets[num % n, 1] + rv
      num /= n
    end
    
    return rv
  end
  
end
 
class Base62 < BaseCodec
  ALPHABETS = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHJIKLMNOPQRSTUVWXYZ"
  def self.decode(s)
    base_n_decode(s, ALPHABETS)
  end
  
  def self.encode(s)
    base_n_encode(s, ALPHABETS)
  end
end

class BaseGowalla < BaseCodec
  ALPHABETS = "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"
  def self.decode(s)
    base_n_decode(s, ALPHABETS)
  end
  
  def self.encode(s)
    base_n_encode(s, ALPHABETS)
  end
 
end
