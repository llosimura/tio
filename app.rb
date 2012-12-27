# coding: utf-8
require 'sinatra'
require 'json'
load 'mactor/actor.rb'
load 'mactor/objective.rb'

actors_list =[]
objectives_list =[]
mao = nil
mid = nil

get '/' do
  haml :index
end

get '/service' do
  haml :service
end

post '/service' do
  begin  
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
    haml :service, :locals => {:msg => "Aqui te mostraria otros resultados!"}
  rescue  
    haml :service, :locals => {:msg => "El JSON era incorrecto", :data => params[:data]}
  end
end

get '/genera' do
   haml :input
end

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
  puts actorsJson

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
  puts objectivesJson

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


