# coding: utf-8
require 'sinatra'
require 'json'
load 'mactor/utils.rb'
load 'mactor/actor.rb'
load 'mactor/objective.rb'
load 'mactor/mactor.rb'

=begin
  Al acceder al index, mostramos la página de inicio
  que nos permitirá rellenar el JSON a mano o por el 
  contrario, seguir una serie de pasos para completarlo
=end
get '/' do
  haml :index
end

=begin
  Una petición get sobre service, nos mostrará el cuadro
  donde rellenaremos el JSON según las convenciones
=end
get '/service' do
  haml :service
end

=begin
   Una petición post sobre service, evaluará el código y 
   nos permitirá aplicar los métodos incluidos en la clase
   mactor para procesar los datos y mostrar los resultados
=end
post '/service' do
  actors_list =[]
  objectives_list =[]
  mao = nil
  mid = nil
  #begin  
    aux = params[:data].gsub(/(\w+)\s*:/, '"\1":')
    data = JSON.parse(aux)
    actors = data["actores"]
    objectives = data["objetivos"]

    #obtenemos los actores desde el JSON
    actors.each do |a|
       data_list = []
       a.each_pair do |k,v|
          data_list << v
       end
       actors_list << Actor.new(*data_list)
    end

    #obtenemos los objetivos desde el JSON
    objectives.each do |o|
       data_list = []
       o.each_pair do |k,v|
          data_list << v
       end
       objectives_list << Objective.new(*data_list)
    end
    #obtenemos la matriz MAO
    mao = data["2MAO"]
    mid = data["MID"]

    #aqui tratamos todas las operaciones
    mactor = Mactor.new()
    mactor.new_actor_list(actors_list)
    mactor.new_objective_list(objectives_list)
    mactor.new_2MAO(mao)
    mactor.new_MID(mid)
    result_midi = mactor.get_MIDI()
    result_ifv = mactor.get_IFV()
    result_mmidi = mactor.get_MMIDI()
    #- get_IFMV() *FALTA
    result_1mao = mactor.get_1MAO()
    result_3mao = mactor.get_3MAO()
    result_1caa = mactor.get_1CAA()
    result_2caa = mactor.get_2CAA()
    result_3caa = mactor.get_3CAA()
    result_1daa = mactor.get_1DAA()
    result_2daa = mactor.get_2DAA()
    result_3daa = mactor.get_3DAA()
    #- get_ambivalence() *FALTA
    #- get_BNI() *FALTA

    #haml :service, :locals => {:msg => "Aqui te mostraria otros resultados!"}
    haml :results, :locals => {
      :midi => result_midi,
      :ifv => result_ifv,
      :mmidi => result_mmidi,
      :one_mao => result_1mao,
      :three_mao => result_3mao,
      :one_caa => result_1caa,
      :two_caa => result_2caa,
      :three_caa => result_3caa,
      :one_daa => result_1daa,
      :two_daa => result_2daa,
      :three_daa => result_3daa,
    }
  #rescue  
   # haml :service, :locals => {:msg => "El JSON era incorrecto", :data => params[:data]}
  #end
end

get '/genera' do
   haml :input
end

=begin
   Una peticion post sobre genera, generará el código
   JSON necesario, según los datos introducidos en el
   tutorial.
=end
post '/genera' do
  #Generamos el JSON actores
  actorsJson = "{ \"actores\" : ["
  params[:actors].each_pair do |id, properties|
    actorsJson << "{"
    properties.each_pair do |prop, val|
      actorsJson <<"\"#{prop}\" :  \"#{val}\","
    end
    actorsJson << "},"
  end
  actorsJson << "],"
  actorsJson.gsub!(",}","}");
  actorsJson.gsub!("},]","}]");

  #Generamos el JSON objetivos
  objectivesJson = "\"objetivos\" : ["
  params[:objectives].each_pair do |id, properties|
  objectivesJson << "{"
    properties.each_pair do |prop, val|
      objectivesJson <<"\"#{prop}\" :  \"#{val}\","
    end
    objectivesJson << "},"
  end
  objectivesJson << "],"
  objectivesJson.gsub!(",}","}");
  objectivesJson.gsub!("},]","}]");

  #Generamos el JSON 2MAO
  maoJson = "\"2MAO\" : ["
  params[:mao].each_pair do |i,v|
    maoJson << "["
    v.each_pair do |j, valor|
      maoJson << valor << ","
    end
    maoJson << "],"
  end
  maoJson << "],"
  maoJson.gsub!(",]", ']')
   
   #Generamos el JSON midi
   midiJson = "\"MIDI\" : ["
   params[:midi].each_pair do |i,v|
     midiJson << "["
     v.each_pair do |j, valor|
        midiJson << valor << ","
     end
     midiJson << "],"
   end
   midiJson << "]}"
   midiJson.gsub!(",]", ']')
   mactorJson = actorsJson + objectivesJson + maoJson + midiJson
   haml :service, :locals => {:fromHelper => mactorJson }
end