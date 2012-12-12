# coding: utf-8
require 'sinatra'

get '/' do
  haml :actors
end

=begin
  Fase1: Creación de la lista de actores
=end 
post '/fase1' do
  puts params[:actors].inspect
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
