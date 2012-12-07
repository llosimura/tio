=begin
 Métodos de cálculo de matrices para Mactor.
 
 Convenciones
  - Variables con nombres en minúscula separados por "_"
  - Nombre de funciones de input: new_<nombre_del_input>(input)
  - Nombre de funciones de output: get_<nombre_del_output>()
 Atributos
    - @actor_list: Lista de objetos Actor
    - @objective_list: Lista de objetos Objective
    - @mao: Matriz 2MAO
    - @mid: Matri MID
 
 Lista de métodos
   Input
    - set_2MAO()
    - set_MID()
   Output 
    - get_1MAO()
    - get_3MAO()
    - get_1CAA()
    - get_2CAA()
    - get_3CAA()
    - get_1DAA()
    - get_2DAA()
    - get_3DAA()
    - get_ambivalence() 
=end
class Mactor
  private
  
  public
    # Constructores
    def initialize()
      @actor_list = []
      @objective_list = []
      @mao = nil
      @mid = nil
    end
    
  public
    # Setters
    def new_actor(actor)
       # El método recibe como parámetro un objeto de tipo Actor
       @actor_list << actor
    end
    
    def new_objective(objective)
      # El método recibe como parámetro un objeto de tipo Objective
      @objective_list << objective
    end
    
    def new_actor_list(actor_list)
      # El método recibe como parámetro una lista de objetos Actor
      @actor_list = actor_list
    end
    
    def new_objective_list(objective_list)
      # El método recibe como parámetro una lista de objetos Objective
      @objective_list = objective_list
    end
    
    def new_2MAO(mao)
      # El método recibe como parámetro una matriz bidimensional de enteros:
      #   - Filas:    Actores (@id del actor)
      #   - Columnas: Objetivos (@id del objetivo)
      @mao = mao
      
    end
    
    def new_MID(mid)
      # El método recibe como parámetro una matriz bidimensional de enteros:
      #   - Filas:    Actores (@id del actor)
      #   - Columnas: Actores (@id del actor)
      @mid = mid
    end
  
  public
    # Getters
    def get_actor_list()
      return @actor_list
    end
    
    def get_objective_list()
      return @objective_list
    end
    
    def get_MID()
      return @mid
    end
    
    def get_2MAO()
      return @mao  
    end
  
    ###################################
    # Cálculo de funciones de output  #
    ###################################
    
    def get_MIDI()
      # Matriz de Influencias Directas e Indirectas
      iterations = @actor_list.size
      midi = Array.new(iterations + 1) { Array.new(iterations + 1)}
      iterations.times do |a|
        iterations.times do |b|
          mid_ab = @mid[a][b]
          sum = 0
          iterations.times do |c|
            sum += [@mid[a][c], @mid[c][b]].min
          end
          midi[a][b] = mid_ab + sum
        end
      end
      # Cálculo de Di
      for a in 0..(iterations - 1) do
        sum = 0
        for b in 0..(iterations - 1) do
          sum += midi[b][a]
        end
        midi[-1][a] = sum - midi[a][a]
      end
      # Cálculo de Ii
      last = 0
      for a in 0..(iterations - 1) do
        sum = 0
        for b in 0..(iterations - 1) do
          sum += midi[a][b]
        end
        midi[a][-1] = sum - midi[a][a]
        last += midi[a][-1]
      end
      # Cálculo del último valor
      midi[-1][-1] = last
      # Valor de retorno
      return midi
    end
    def get_IFV()
      # Informe de Fuerza bajo forma de Vector
      return 0
    end
    def get_MMIDI()
      # Matriz de Máxima Influencia Directa e Indirecta
      return 0
    end
    def get_IFMV()
      # Informe de Fuerza Máxima bajo forma de Vector
      return 0
    end
    # Relación entre actores y objetivos
    def get_1MAO()
      return 0
    end
    def get_3MAO()
      return 0
    end
    # Convergencia entre actores y objetivos
    def get_1CAA()
      return 0
    end
    def get_2CAA()
      return 0
    end
    def get_3CAA()
      return 0
    end
    # Divergencia entre actores y objetivos
    def get_1DAA()
      return 0
    end
    def get_2DAA()
      return 0
    end
    def get_3DAA()
      return 0
    end
    # Ambigüedades del actor
    def get_ambivalence()
      return 0
    end 
end