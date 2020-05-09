module Enumerables
    def my_each(arr)
        if arr.is_a?(Array)
            0.upto arr.length - 1 do |value|
                if block_given?
                    yield(arr[value]) 
                else
                    puts arr[value]
                end
            end
        end
            
        if arr.is_a?(Range)
            for val in arr
                if block_given?
                    yield(val)
                else
                    puts val
                end
            end
        end 
    end    


end

