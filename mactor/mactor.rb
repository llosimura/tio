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
      @mao = null
      @mid = null
    end
    
  public
    # Setters
    def new_actor(actor)
       # El método recibe como parámetro un objeto de tipo Actor
       @actor << actor
    end
    
    def new_objective(objective)
      # El método recibe como parámetro un objeto de tipo Objective
      @objective << objective
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
  
    # Cálculo de funciones de output
    def get_1MAO()
      return 0
    end
    def get_3MAO()
      return 0
    end
    def get_1CAA()
      return 0
    end
    def get_2CAA()
      return 0
    end
    def get_3CAA()
      return 0
    end
    def get_1DAA()
      return 0
    end
    def get_2DAA()
      return 0
    end
    def get_3DAA()
      return 0
    end
    def get_ambivalence()
      return 0
    end 
end