class FileReader
  def self.read_file(file_path)
    @combination = Hash.new(0)
    @letters = Hash.new(0)
    @l_count = 0
    @c_count = 0
    @text = ''
    f = File.open(file_path, 'r')
    f.each_line do |line|
      @text += line
      dl = line.downcase
      calculate_lc(dl)
    end
    { text: @text, letters: @letters, combination: @combination,
      c_count: @c_count, l_count: @l_count }
  end

  def self.calculate_lc(dl)
    for i in 1...dl.size
      if dl[i] != "\n" && dl[i - 1] != "\n"
        @combination[dl[i - 1..i]] += 1
        @c_count += 1
      end
    end
    for i in 0...dl.size
      @letters[dl[i]] += 1
      @l_count += 1
    end
  end
end