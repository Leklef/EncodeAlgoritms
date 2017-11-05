require_relative 'huffman_coding'
require_relative 'status_module'

class Huffman
  # модуль отвечающий за коддирование по Хаффмону
  include HuffmanCoding
  include StatusModule

  def read_file(encoding_table)
    File.open('h_encoded.txt', 'rb') do |file|
      File.open('h_decode.txt', 'w') do |output|
        bit_string = ''
        byte = file.read(1)
        while byte
          byte = byte.ord
          bits = byte.to_s(2).rjust(8, '0')
          bit_string += bits
          byte = file.read(1)
        end
        decompressed_text = decode(bit_string, encoding_table)
        output.write(decompressed_text)
      end
    end
   end

  def write_file(text, encoding_table)
    chars = ''
    @bytes = ''
    File.open('h_encoded.txt', 'wb') do |file|
      text.each_char do |c|
        if c != "\n"
          chars += encoding_table[c].to_s
        end
      end
      (0...chars.length).step(8).each do |i|
        @bytes += chars[i...i + 8].to_i(2).chr
      end
      file.write(@bytes)
    end
    show_p_bar
    puts("\nФайл успешно закодирован")
    puts("Размер исходного файла: #{File.size('text.txt').to_f}")
    puts("Размер закодированного файла: #{File.size('h_encoded.txt').to_f}")
    puts(chars.length.to_f / text.length)
  end
end

file = FileReader.read_file('text.txt')
c_huff = Huffman.new
cod_tab = c_huff.calculate_encoding_table(file[:letters])
c_huff.write_file(file[:text], cod_tab)
c_huff.read_file(cod_tab)