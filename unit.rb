class Unit
  # Класс, представляет собой объект содержаний поля name, value, code
  # :param name: имя объекта
  # :param code: код объекта
  # :param value: значение вероятности

  attr_accessor :name, :value, :code

  def initialize(name, value, code)
    @name = name
    @value = value
    @code = code
  end
end