module Enumerable
  def my_each
    if is_a?(Array)
      0.upto size - 1 do |val|
        yield(self[val]) if block_given?
      end
    elsif is_a?(Range)
      each do |val|
        yield(val) if block_given?
      end
    else
      hash_keys = keys
      0.upto hash_keys.length - 1 do |num|
        key = hash_keys[num]
        yield(key, self[key])
      end
    end
  end

  def my_each_with_index
    0.upto size - 1 do |val|
      yield(self[val], val)
    end
  end

  def my_select
    return_arr = []
    return_hash = {}
    if is_a?(Hash)
      my_each do |key, val|
        return_hash[key] = val if yield(key, val)
      end
      return_hash
    else
      my_each do |val|
        return_arr.push(val) if yield(val)
      end
      return_arr
    end
  end

  def my_all?
    ans = false
    if is_a?(Hash)
      my_each do |key, val|
        if yield(key, val)
          ans = true
        else
          ans = false
          break
        end
      end
    else
      my_each do |val|
        if yield(val)
          ans = true
        else
          ans = false
          break
        end
      end
    end
    ans
  end

  def my_any?
    ans = false
    if is_a?(Hash)
      my_each do |key, val|
        if yield(key, val)
          ans = true
          break
        else
          ans = false
        end
      end
    else
      my_each do |val|
        if yield(val)
          ans = true
          break
        else
          ans = false
        end
      end
    end
    ans
  end

  def my_none?
    ans = false
    if is_a?(Hash)
      my_each do |key, val|
        if yield(key, val)
          ans = false
          break
        else
          ans = true
        end
      end
    else
      my_each do |val|
        if yield(val)
          ans = false
          break
        else
          ans = true
        end
      end
    end
    ans
  end

  def my_count(args = nil)
    ans = 0
    if block_given?
      my_each do |val|
        ans += 1 if yield(val)
      end
    elsif args.nil?
      ans = size
    else
      my_each do |val|
        ans += 1 if val == args
      end
    end
    ans
  end

  def my_map(args = nil)
    return_arr = []
    if block_given? && args.is_a?(Proc)
      my_each do |val|
        return_arr.push(args.call(val))
      end
    elsif !block_given? && args.is_a?(Proc)
      my_each do |val|
        return_arr.push(args.call(val))
      end
    else
      my_each do |val|
        return_arr.push(yield(val))
      end
    end
    pp return_arr
  end

  def my_inject(arg1 = nil, arg2 = nil)
    acc = nil
    symbol = nil
    if arg1.is_a?(Numeric)
      acc = arg1
      symbol = arg2 if arg2.is_a?(Symbol)
    end
    symbol = arg1 if arg1.is_a?(Symbol)
    if !symbol.nil?
      my_each do |val|
        acc = acc ? acc.send(symbol, val) : val
      end
    else
      my_each do |val|
        acc = acc ? yield(acc, val) : val
      end
    end
    acc
  end
end

def multiply_els(args)
  args.my_inject { |acc, val| acc * val }
end
