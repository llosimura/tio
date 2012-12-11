# coding: utf-8
require 'sinatra'
require 'json'

get '/' do
  haml :actors
end

get '/service' do
  haml :service, :locals => {:msg => "", :data => ""}
end

post '/service' do
  begin  
    pepe = params[:data].gsub(/(\w+)\s*:/, '"\1":')
    data = JSON.parse(pepe)
    puts data.inspect  
    haml :service, :locals => {:msg => "", :data => ""}
  rescue  
    haml :service, :locals => {:msg => "El JSON era incorrecto", :data => params[:data]}
  end 
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
