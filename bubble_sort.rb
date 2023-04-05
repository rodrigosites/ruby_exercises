def bubble_sort(array)
  begin
    sorted = false
    array.each_index do |i|
      unless array[i+1].nil? 
        if array[i] > array[i+1]
          array[i], array[i+1] = array[i+1], array[i]
          sorted = true
        end
      end
    end
  end while sorted
  array
end

p bubble_sort([4,3,78,2,0,2])