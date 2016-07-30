# Guia básica de Ruby

Twitter, Souncloud, Github comenzaron con Ruby, aguante Ruby vieja no me importa nada.

	#EstoEsUnComentario

El método `puts` imprime en consola

	puts "Hola mundo"

###Variables

Declaración

	heroe = "Mud"

Interpolación:

	puts "Hola #{heroe}, bienvenido."

###Funciones

####Función LEVEL 1

	def saludo
		puts "Hola"
	end

	saludo

####Función LEVEL 2

	def saludo(texto)
		return texto
	end

	puts saludo("Hola")

####Función LEVEL 3

Se puede declarar un valor por defecto

	def saludo(texto,usuario="anonimo")
		return texto+usuario
	end

	puts saludo("Hola ","Mud")
