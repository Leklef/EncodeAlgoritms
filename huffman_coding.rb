module HuffmanCoding
  def encode(frequency)
    heap = Array.new([])
    frequency.each do |symbol, weight|
      heap << [weight, Unit.new(symbol, weight, '')]
    end
    while heap.length > 1
      heap = heap.sort_by { |obj| obj[0] }
      lo = heap[0]
      hi = heap[1]
      for i in 1...lo.length
        lo[i].code = '1' + lo[i].code
      end
      for i in 1...hi.length
        hi[i].code = '0' + hi[i].code
      end
      for i in 1...hi.length
        lo << hi[i]
      end
      lo[0] = lo[0] + hi[0]
      heap[0] = lo
      heap.delete(heap[1])
    end
    heap[0][1...heap[0].length]
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
    huff = encode(frequency)
    encoding_table = Hash.new(0)
    File.open('legend.txt', 'w') do |file|
      huff.each do |p|
        file.write(p.name.ljust(10) + p.value.to_s.ljust(10) + p.code + "\n")
        encoding_table[p.name] = p.code
      end
    end
    encoding_table
  end
end