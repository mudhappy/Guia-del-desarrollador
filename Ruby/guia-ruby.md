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

##Números

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

###Más números

Sintaxis de un número decimal

	9 / 2 = 4 #FAIL
	9.0/2.0 = 4.5 #WIN

¿Es un número real?

	(9.0).real?

Multiplicar cadena

	"Hola"*10	

####Redondear

Abajo

	(9.0/2.0).floor
	
Arriba	

	(9.0/2.0).ceil

####Aumentar decimal

Abajo

	(9.0/2.0).next_float
	
Arriba	

	(9.0/2.0).prev_float

##Conversión

Obtener valor de consola (devuelve una cadena)

	nombre = gets

Convertir a entero

	(9.0/2.0).to_i

Convertir a flotante

	(9.0/2.0).to_f

Convertir a cadena

	(9.0/2.0).to_s
