def caesar_cipher(string, shift_factor)
  downcase_letters = (97..122).to_a
  upcase_letters = (65..90).to_a
  string_bytes = string.bytes
  string_bytes.each_index do |index|
    if downcase_letters.include? (string_bytes[index])
      if downcase_letters.include? (string_bytes[index] - shift_factor)
        string_bytes[index] -= shift_factor
      else
        string_bytes[index] = 123 - (97 - (string_bytes[index] - shift_factor))
      end
    elsif upcase_letters.include? (string_bytes[index])
      if upcase_letters.include? (string_bytes[index] - shift_factor)
        string_bytes[index] -= shift_factor
      else
        string_bytes[index] = 91 - (65 - (string_bytes[index] - shift_factor))
      end
    end
    print string_bytes[index].chr
  end
end

caesar_cipher("Indeed, this text looks very complex after cryptography!",5)

