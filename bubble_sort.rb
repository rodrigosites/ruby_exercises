def bubble_sort(array)
  loop do
    sorted = false
    array.each_index do |i|
      if !array[i + 1].nil? && array[i] > array[i + 1]
        array[i], array[i + 1] = array[i + 1], array[i]
        sorted = true
      end
    end
    break unless sorted
  end
  array
end

p bubble_sort([4, 3, 78, 2, 0, 2])