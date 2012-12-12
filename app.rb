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
  haml :actors
end

get '/service' do
  haml :service, :locals => {:msg => "", :data => ""}
end

post '/service' do
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
    2mao = data["2MAO"]
    mid = data["MID"]

    haml :service, :locals => {:msg => "", :data => ""}
  #rescue  
   # haml :service, :locals => {:msg => "El JSON era incorrecto", :data => params[:data]}
  #end 
end

=begin
  Fase1: Creación de la lista de actores
=end 
post '/fase1' do
  prueba = params[:actors].clone
  prueba.each_pair do |id, properties|
    properties.each_pair do |prop, val|
      puts "#{id}: #{prop} #{val}"
    end
  end
end

=begin
   Fase2: Creación de la lista de objetivos
=end
post '/fase2' do
end


post '/fase3' do
end

post '/fase4' do
end

post '/fase5' do
end

post '/fase6' do
end

post '/fase7' do
end
