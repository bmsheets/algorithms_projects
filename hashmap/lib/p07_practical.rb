require_relative 'p05_hash_map'

def can_string_be_palindrome?(string) 
    map = HashMap.new  
    string.each_char do |char|
        if map[char]
            map[char] += 1
        else
            map[char] = 1
        end 
    end
    num_odds = 0
    map.each do |key, val|
        num_odds += 1 if val.odd?
    end 
    num_odds < 2
end
