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
    - get_MIDI()
    - get_IFV()
    - get_MMIDI()
    - get_IFMV() *FALTA
    - get_1MAO()
    - get_3MAO()
    - get_1CAA()
    - get_2CAA() 
    - get_3CAA()
    - get_1DAA()
    - get_2DAA() 
    - get_3DAA() 
    - get_ambivalence() *FALTA
    - get_BNI() *FALTA
=end
#load 'utils.rb'

class Mactor
  private

#####################################
#    Refactorización de cálculos    #
#####################################

  def get_CAA(number)
    # Matrices necesarias para los calculos
    mao = nil
    case number
      when 1
        mao = get_1MAO
      when 2
        mao = get_2MAO
      when 3
        mao = get_3MAO
    end
    # Eliminacion de filas y columnas de información extra
    if (number == 1) || (number == 3)
      3.times do
        mao.delete_at(-1)
      end
      mao.size.times do |i|
        mao[i].delete_at(-1)
      end
    end
    # Valor absoluto de la matriz
    maoabs = mao.map {|i| i.map {|j| j.abs}}
    # Creación de matriz de salida
    rows = mao.size
    cols = mao.size
    objectives = mao[0].size
    caa = Array.new(rows+1) { Array.new(cols) }
    # Cálculo de 1CAA
    rows.times do |i|
      cols.times do |j|
        if i == j
          caa[i][j] = 0.0
        else
          caa[i][j] = 0.0
          objectives.times do |k|
            if (mao[i][k] * mao[j][k] > 0)
              caa[i][j] += 0.5 * (maoabs[i][k] + maoabs[j][k])
            else
              caa[i][j] += 0
            end
          end
        end
      end
    end
    # Cálculo del número de convergencias
    cols.times do |j|
      caa[rows][j] = 0
      rows.times do |k|
        caa[rows][j] += caa[k][j]
      end
    end
    return caa
  end

  def get_DAA(number)
    # Matrices necesarias para los calculos
    mao = nil
    case number
      when 1
        mao = get_1MAO
      when 2
        mao = get_2MAO
      when 3
        mao = get_3MAO
    end
    # Eliminacion de filas y columnas de información extra
    if (number == 1) || (number == 3)
      3.times do
        mao.delete_at(-1)
      end
      mao.size.times do |i|
        mao[i].delete_at(-1)
      end
    end
    # Valor absoluto de la matriz
    maoabs = mao.map {|i| i.map {|j| j.abs}}
    # Creación de matriz de salida
    rows = mao.size
    cols = mao.size
    objectives = mao[0].size
    daa = Array.new(rows+1) { Array.new(cols) }
    # Cálculo de 1CAA
    rows.times do |i|
      cols.times do |j|
        if i == j
          daa[i][j] = 0.0
        else
          daa[i][j] = 0.0
          objectives.times do |k|
            if (mao[i][k] * mao[j][k] < 0)
              daa[i][j] += 0.5 * (maoabs[i][k] + maoabs[j][k])
            else
              daa[i][j] += 0
            end
          end
        end
      end
    end
    # Cálculo del número de convergencias
    cols.times do |j|
      daa[rows][j] = 0
      rows.times do |k|
        daa[rows][j] += daa[k][j]
      end
    end
    return daa
  end

  def add_LastRowCAA(caa, number)
    # Calculo del valor del Grado de Convergencia para
    # 2CAA y 3CAA
    daa = nil
    case number
      when 2
        daa = get_DAA(2)
      when 3
        daa = get_DAA(3)
    end
    numerador = 0
    denominador = 0

    (caa.size).times do |i|
      (caa[0].size).times do |j|
        numerador += caa[i][j]
        denominador += caa[i][j] + daa[i][j]
      end
    end
    caa << (numerador/denominador * 100)
    return caa
  end

  def add_LastRowDAA(daa, number)
    # Calculo del valor del Grado de Divergencia para
    # 2DAA y 3DAA
    caa = nil
    case number
      when 2
        caa = get_CAA(2)
      when 3
        caa = get_CAA(3)
    end
    numerador = 0
    denominador = 0

    (daa.size).times do |i|
      (daa[0].size).times do |j|
        numerador += daa[i][j]
        denominador += caa[i][j] + daa[i][j]
      end
    end
    daa << (numerador/denominador * 100)
    return daa
  end

  public
############################
#     Constructores        #
############################

    def initialize()
      @actor_list = []
      @objective_list = []
      @mao = nil
      @mid = nil
    end
    
  public
############################
#         Setters          #
############################
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
############################
#         Getters          #
############################
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
=begin
      Matriz de Influencias Directas e Indirectas
=end
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
=begin
      Informe de Fuerza bajo forma de Vector
=end
      midi = self.get_MIDI
      ifv = []
      iterations = @actor_list.size
      # Cálculo del vector sin normalizar
      iterations.times do |a|
        r = ( (midi[a][-1] - midi[a][a]) / midi[-1][-1].to_f ) * ( midi[a][-1] / (midi[a][-1] + midi[-1][a]).to_f )
        ifv << r
      end
      # Normalización del vector
      sum_r = 0
      ifv.each { |a| sum_r += a}
      ifv = ifv.map do |a|
        (iterations * a) / sum_r.to_f      
      end
      return ifv
    end
    
    def get_MMIDI()
=begin
      Matriz de Máxima Influencia Directa e Indirecta
=end
      iterations = @actor_list.size
      mmidi = Array.new(iterations + 1) { Array.new(iterations + 1) }
      iterations.times do |i|
        iterations.times do |j|    
          # Para cada una de las casillas...
          num3 = 0
          num4 = 0
          iterations.times do |k|
            num4 = [@mid[i][k], @mid[k][j]].min
            num3 = [num3, num4].max
          end
          mmidi[i][j] = [@mid[i][j], num3].max
        end
        mmidi[i][i] = 0
      end
      return mmidi
    end
    
    def get_IFMV()
=begin
      Informe de Fuerza Máxima bajo forma de Vector
=end
      return 0
    end
    
  # Apartado de relación entre actores y objetivos
    def get_1MAO()
=begin
      Matriz 1MAO
=end
      cols = @objective_list.size
      rows = @actor_list.size
      onemao = Array.new(rows+3) {Array.new(cols + 1)}
      # Cálculo del contenido
      rows.times do |a|
        cols.times do |b|
          if (@mao[a][b] > 0)
            onemao[a][b] = 1
          elsif (@mao[a][b] == 0)
            onemao[a][b] = 0
          else
            onemao[a][b] = -1
          end 
        end
      end
      # Cálculo de la columna 'Suma absoluta'
      rows.times do |a|
        sum = 0
        cols.times do |b|
          if onemao[a][b] != 0
            sum += 1
          end
        end
        onemao[a][-1] = sum
      end
      # Cálculo de las filas inferiores
      # Número de acuerdos
      row = @actor_list.size
      cols.times do |b|
         sum = 0
         rows.times do |a|
           if (onemao[a][b] == 1)
             sum += 1
           end
         end
         onemao[row][b] = sum
      end
      # Número de desacuerdos
      row += 1
      cols.times do |b|
         sum = 0
         rows.times do |a|
           if (onemao[a][b] == -1)
             sum -= 1
           end
         end
         onemao[row][b] = sum
      end
      # Número de posiciones
      row += 1
      cols.times do |b|
         sum = 0
         rows.times do |a|
           if (onemao[a][b] == 1) or (onemao[a][b] == -1)
             sum += 1
           end
         end
         onemao[row][b] = sum
      end
      return onemao
    end
    
    def get_3MAO()
      mao = get_2MAO
      r = get_IFV
      cols = mao[0].size
      rows = mao.size
      threemao = Array.new(rows+3) {Array.new(cols + 1)}
      
      # Calculo del contenido de la matriz y de la columna
      # de movilización
      rows.times do |i|
        movilizacion = 0
        cols.times do |j|
          threemao[i][j] = r[i] * mao[i][j]
          movilizacion += threemao[i][j].abs
        end
        threemao[i][-1] = movilizacion
      end
      
      # Cálculo de las filas inferiores
      # Número de acuerdos
      row = @actor_list.size
      cols.times do |b|
         sum = 0
         rows.times do |a|
           if (threemao[a][b] > 0)
             sum += threemao[a][b]
           end
         end
         threemao[row][b] = sum
      end
      # Número de desacuerdos
      row += 1
      cols.times do |b|
         sum = 0
         rows.times do |a|
           if (threemao[a][b] < 0)
             sum += threemao[a][b]
           end
         end
         threemao[row][b] = sum
      end
      # Grado de movilización
      row += 1
      cols.times do |b|
        threemao[row][b] = threemao[row-1][b].abs + threemao[row-2][b]
      end      
      return threemao
    end

    
    # Apartado de convergencia entre actores y objetivos
    def get_1CAA()
      caa = get_CAA(1)
      return caa
    end
    
    def get_2CAA()
      caa = get_CAA(2)
      caa = add_LastRowCAA(caa, 2)
      return caa
    end
    
    def get_3CAA()
      caa = get_CAA(3)
      caa = add_LastRowCAA(caa, 3)
      return caa
    end
    

    
    # Apartado de divergencia entre actores y objetivos
    def get_1DAA()
      daa = get_DAA(1)
      return daa
    end
    
    def get_2DAA()
      daa = get_DAA(2)
      #print "2DAA PARA PASAR\n", daa, "\n"
      daa = add_LastRowDAA(daa, 2)
      return daa
    end
    
    def get_3DAA()
      daa = get_DAA(3)
      daa = add_LastRowDAA(daa, 3)
      return daa
    end
    
    # Ambigüedades del actor
    def get_ambivalence()
	  cols = 3
	  rows = @actor_list.size
	  amb = Array.new(rows) {Array.new(cols)}
	  cols.times do |i|
         caa = get_CAA(i+1)
		 daa = get_DAA(i+1)
         rows.times do |j|
			sum_up = 0
			sum_down= 0
			rows.times do |k|
				sum_up += ((caa[j][k]).abs - (daa[j][k]).abs).abs
				sum_down += ((caa[j][k]).abs + (daa[j][k]).abs).abs
			end
			amb[j][i] = 1 - (sum_up/sum_down)
         end 
	  end		
      return amb
    end

    def get_BNI()
      return 0
    end
end