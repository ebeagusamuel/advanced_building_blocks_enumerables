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
		puts ans
	end

end
x = {one: 100, two: 200, three: 300, four: 400}
x.my_all?{ |k, v| v > 100}