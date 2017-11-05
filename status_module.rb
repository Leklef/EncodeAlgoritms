require_relative 'Unit'
require_relative 'FileReader'
require 'progress_bar'
module StatusModule
  def show_p_bar
    bar = ProgressBar.new
    100.times do
      sleep 0.01
      bar.increment!
    end
    sleep 0.01
  end
end