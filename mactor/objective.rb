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
  attr_accessor :id, :long_title, :short_title, :game, :description
  
  def initialize(id, long_title, short_title, game, description)
    @id = id
    @long_title = long_title
    @short_title = short_title
    @game = game
    @description = description
  end
end