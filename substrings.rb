dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings (word, text_array)
  substrings_hash = text_array.to_h { |s| [s,0] }
  word_substrings = []
  for char in 0..word.length-1 do
    if word.chars[char].match?(/[a-zA-Z]+/)
      word_substrings.push(word.chars[char].downcase)
      if substrings_hash.include?(word_substrings.last)
        substrings_hash[word_substrings.last] += 1
      end
      next_char = char + 1
      while next_char < word.length && word.chars[next_char].match?(/[a-zA-Z]+/) do
        word_substrings.push("#{word_substrings.last}#{word.chars[next_char].downcase}")
        if substrings_hash.include?(word_substrings.last)
          substrings_hash[word_substrings.last] += 1
        end
        next_char += 1
      end
    else
      next
    end
  end
  puts substrings_hash.select { |k,v| v > 0 }
end

substrings("Howdy partner, sit down! How's it going?", dictionary)