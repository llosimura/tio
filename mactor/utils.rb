=begin
 Métodos utiles para la transformación y operación con matrices 
=end

def multiply(matrix1, matrix2)
=begin
  Método para multiplicar dos matrices
=end 
  # Dimensiones matriz1
  first_rows = matrix1.size
  first_cols = matrix1[0].size
  # Dimensiones matriz2
  second_rows = matrix2.size
  second_cols = matrix2[0].size
  # Dimensiones matriz producto
  output_rows = matrix1.size
  output_cols = matrix2[0].size
  output = Array.new(output_rows) {Array.new(output_cols)}
  # Multiplicación
  for i in 0..(first_rows -1) do
    for j in 0..(second_cols -1) do
      output[i][j] = 0
      for k in 0..(first_cols - 1) do
        output[i][j] += matrix1[i][k] * matrix2[k][j]
      end
    end
  end
  return output
end
