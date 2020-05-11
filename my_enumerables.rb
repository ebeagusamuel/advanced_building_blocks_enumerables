module Enumerable
	def my_each
		if is_a?(Array)
			0.upto size - 1 do |val|
				if block_given?
					yield(self[val]) 
				end
			end
		elsif is_a?(Range)
			for val in self
				if block_given?
					yield(val)
				end
			end
		else
			hash_keys = self.keys
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
			self.my_each do |key, val|
				if yield(key, val)
					return_hash[key] = val
				end
			end
			return_hash
		else
			self.my_each do |val|
				if yield(val)
					return_arr.push(val)
				end
			end
			return_arr
		end
	end

	def my_all?
		ans = false
		if is_a?(Hash)
			self.my_each do |key, val|
				if yield(key, val)
					ans = true
				else
					ans = false
					break
				end
			end
		else
			self.my_each do |val|
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
			self.my_each do |key, val|
				if yield(key, val)
					ans = true
					break
				else
					ans = false
				end
			end
		else
			self.my_each do |val|
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
			self.my_each do |key, val|
				if yield(key, val)
					ans = false
					break
				else
					ans = true
				end
			end
		else
			self.my_each do |val|
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

end
x = [20, 30, 40, 50, 60, 70, 80, 90]
x.my_none?{ |v| v >= 100}