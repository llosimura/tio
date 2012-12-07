=begin
  Clase que define los objetos de tipo Actor en el sistema.
  Los atributos que tienen son:
    -ID numérico: @id
    -Título largo: @long_title
    -Título corto: @short_title
    -Descripción: @description
=end

class Actor
  attr_accessor :id, :long_title, :short_title, :description
  
  def initialize(id, long_title, short_title, description)
    @id = id
    @long_title = long_title
    @short_title = short_title
    @description = description
  end
end