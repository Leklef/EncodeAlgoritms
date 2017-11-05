require_relative 'status_module'
require_relative 'shannon_fano_coding'
class CombinationSF
  include ShannonFanoCoding
  include StatusModule
  def read_file(encoding_table)
    File.open('csf_encoded.txt', 'rb') do |file|
      File.open('csf_decode.txt', 'w') do |output|
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
    File.open('сsf_encoded.txt', 'wb') do |file|
      (1...text.length - 1).step(2).each do |i|
        if text[i] != "\n" && text[i - 1] != "\n"
          chars += encoding_table[text[i - 1] + text[i]].to_s
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
    puts("Размер закодированного файла: #{File.size('сsf_encoded.txt').to_f}")
    puts(chars.length.to_f / text.length)
  end
end

file = FileReader.read_file('text.txt')
c_sh = CombinationSF.new
cod_tab = c_sh.calculate_encoding_table(file[:combination])
c_sh.write_file(file[:text], cod_tab)
c_sh.read_file(cod_tab)