# frozen_string_literal: true

# rubocop : disable Metrics/ModuleLength
# rubocop : disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
# rubocop : disable Metrics/MethodLength
# rubocop : disable Style/Documentation
# rubocop : disable Metrics/AbcSize

module Enumerable
  def my_each
    return to_enum :my_each unless block_given?

    0.upto size - 1 do |val|
      case self.class.name
      when 'Hash' then yield(keys[val], self[keys[val]])
      when 'Array' then yield(self[val])
      when 'Range' then yield(to_a[val])
      end
    end
    self
  end

  def my_each_with_index
    return to_enum :my_each unless block_given?

    0.upto size - 1 do |val|
      yield(self[val], val)
    end
    self
  end

  def my_select
    return to_enum :my_select unless block_given?

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

  def my_all?(args = nil)
    if args.nil?
      if block_given?
        my_each { |val| return false unless yield(val) }
      else
        my_each { |val| return false unless val }
      end
    elsif args.is_a?(Regexp)
      my_each { |val| return false unless val.match(args) }
    elsif args.is_a?(Module)
      my_each { |val| return false unless val.is_a?(args) }
    else
      my_each { |val| return false unless val == args }
    end
    true
  end

  def my_any?(args = nil)
    if args.nil?
      if block_given?
        my_each { |val| return true if yield(val) }
      else
        my_each { |val| return true if val }
      end
    elsif args.is_a?(Regexp)
      my_each { |val| return true if val.match(args) }
    elsif args.is_a?(Module)
      my_each { |val| return true if val.is_a?(args) }
    else
      my_each { |val| return true if val == args }
    end
    false
  end

  def my_none?(args = nil)
    if args.nil?
      if block_given?
        my_each { |val| return false if yield(val) }
      else
        my_each { |val| return false if val }
      end
    elsif args.is_a?(Regexp)
      my_each { |val| return false if val.match(args) }
    elsif args.is_a?(Module)
      my_each { |val| return false if val.is_a?(args) }
    else
      my_each { |val| return false if val == args }
    end
    true
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
    return to_enum :my_map unless block_given?

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
    return_arr
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

# rubocop : enable Metrics/ModuleLength
# rubocop : enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
# rubocop : enable Metrics/MethodLength
# rubocop : enable Style/Documentation
# rubocop : enable Metrics/AbcSize

def multiply_els(args)
  args.my_inject { |acc, val| acc * val }
end
