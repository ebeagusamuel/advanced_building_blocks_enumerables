
	def my_each(arr)
		if arr.is_a?(Array)
			0.upto arr.length - 1 do |val|
				if block_given?
					yield(arr[val]) 
				else
					arr[val]
				end
			end
		end
				
		if arr.is_a?(Range)
			for val in arr
				if block_given?
					yield(val)
				else
					val
				end
			end
		end 
	end    

	def my_each_with_index(arr)
		0.upto arr.length - 1 do |val|
			if block_given?
				yield(arr[val], val)
			else
				puts "#{arr[val]} #{val}"
			end
		end
	end
