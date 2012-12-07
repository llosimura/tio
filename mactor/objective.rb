=begin
  Clase que define los objetos de tipo Objetivo en el sistema.
  Los atributos que tienen son:
    -ID numérico: @id
    -Título largo: @long_title
    -Título corto: @short_title
    -Juego: @game
    -Descripción: @description
=end

class Objective
  attr_accessible :number, :long_title, :short_title, :game, :description
end