# coding: utf-8
require 'sinatra'

pepe = 1

get '/' do
	haml :actors
end

=begin
  Fase1: Creación de la lista de actores
=end 
post '/fase1' do
	puts params[:actor]
	haml :index if params[:actors].nil?
end

=begin
   Fase2: Creación de la lista de objetivos
=end
get '/fase2' do
	pepe = 3
end


get '/fase3' do
	puts "la variables es #{pepe}"
end

post '/fase4' do
end

post '/fase5' do
end

post '/fase6' do
end

post '/fase7' do
end