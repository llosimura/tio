=begin
 Pruebas para la clase Mactor. Basadas en el ejemplo del programa Mactor:
 "aeroport de paris" 
=end
load 'actor.rb'
load 'mactor.rb'
load 'objective.rb'

# Crear objeto Mactor
mactor = Mactor.new()

# Crear lista de actores
a1 = Actor.new(1, "Constructeurs", "Constr.", "Description des constructeurs")
a2 = Actor.new(2, "Compagnies Regulieres", "Cies Regulieres", "Description des Compagnies Regulieres")
a3 = Actor.new(3, "Compagnies Charter", "Cies Charter", "Description des Compagnies Charter")
a4 = Actor.new(4, "Etat", "Etat", "Description de l'Etat")
a5 = Actor.new(5, "Aeroport Paris", "AP", "Description de Aeroport Paris")
a6 = Actor.new(6, "Association Riverains", "Assoc. Riv.", "Description de l'Association des Riverains")
mactor.new_actor_list([a1, a2, a3, a4, a5, a6])

# Crear lista de objetivos
o1 = Objective.new(1, "Caracteristiques Avions", "Car_avions", "a new topic", "Descripion des Caracteristiques Avions")
o2 = Objective.new(2, "Marche", "Marche", "a new topic", "Description du Marche")
o3 = Objective.new(3, "Droits", "Droits", "a new topic", "Description des Droits")
o4 = Objective.new(4, "Vols Organises", "Vols_Orga", "a new topic", "Description des Vols Organises")
o5 = Objective.new(5, "Normes sur le bruit", "Normes_Bru", "a new topic", "Description ds Normes sur le bruit")
mactor.new_objective_list([o1, o2, o3, o4, o5])

# Crear matriz 2MAO
mao = [ [2, 3, 0, 0, 1],
        [-2, 0, 3, -1, -3],
        [-1, 0, -3, 3, -2],
        [0, 3, 2, 0, 1],
        [-1, 0, -2, 2, -2],
        [0, 0, 0, 0, 3] ]
mactor.new_2MAO(mao)

# Crear matriz MID
mid = [ [0, 1, 1, 3, 0, 2],
        [2, 0, 3, 2, 1, 1],
        [1, 2, 0, 1, 1, 0],
        [2, 3, 3, 0, 3, 2],
        [0, 2, 3, 1, 0, 2],
        [0, 1, 1, 3, 2, 0] ]
mactor.new_MID(mid)

# Testeo de metodos
# MIDI
print "MIDI: \n", mactor.get_MIDI, "\n"
