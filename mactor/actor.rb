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
end