# Guia básica de Ruby

Twitter, Souncloud, Github comenzaron con Ruby, aguante Ruby vieja no me importa nada.

##Primeros pasos

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

###Operaciones aritméticas

>Un número es un objeto
	
	8.class
	
Siguiente

	8.next

Anterior

	8.pred

¿Cero?, ¿Par?, ¿Impar?

	8.zero?
	8.even?
	8.odd?
