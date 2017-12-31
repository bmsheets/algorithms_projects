class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    total = 0
    self.each_with_index do |el, idx|
        if el.is_a?(String)
            token = el.ord
        else
            token = el.to_i
        end
        total += token * (idx + 1)
    end
    total.hash
  end
end

class String
  def hash
    self.chars.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.flatten.map {|el| el.to_s}.sort.hash
  end
end
