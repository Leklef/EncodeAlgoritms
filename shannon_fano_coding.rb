require_relative 'FileReader'
require_relative 'Unit'
module  ShannonFanoCoding
  def encode(frequency)
    sum = 0.0
    frequency.each do |i|
      sum += i.value
    end
    group = sum.to_f / 2
    index = 0.0
    # да простит меня святой КотЭ за нерациональное использование памяти
    group1 = []
    group2 = []
    frequency.each do |i|
      if index < group
        i.code += '0'
        group1 << i
        index += i.value
      else
        i.code += '1'
        group2 << i
      end
    end
    if group1.length != 1
      encode(group1)
    end
    if group2.length != 1
      encode(group2)
    end
    frequency
  end
  def decode(encoded_text, encoding_table)
    decoded_text = ''
    buffer = ''
    encoded_text.each_char do |char|
      buffer += char
      encoding_table.each do |letter, code|
        if buffer == code
          decoded_text += letter
          buffer = ''
        end
      end
    end
    decoded_text
  end
  def calculate_encoding_table(frequency)
    huff = encode(hash_to_a(frequency))
    encoding_table = Hash.new(0)
    File.open('legend.txt', 'w') do |file|
      huff.each do |p|
        file.write(p.name.ljust(10) + p.value.to_s.ljust(10) + p.code + "\n")
        encoding_table[p.name] = p.code
      end
    end
    encoding_table
  end
  def hash_to_a(letters)
    codes = []
    letters.each do |key, value|
      codes << Unit.new(key, value, '')
    end
    codes
  end
end