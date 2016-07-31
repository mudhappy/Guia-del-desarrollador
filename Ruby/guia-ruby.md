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

###Operadores lógicos

Al igual que en otros lenguajes `==`,`!=``>=`,`<=` para números y cadenas.

####Condicional IF

	if a<b
		#code
	end

o también

	if a<b
		#code
	else
		#code
	end

o también

	if a<b
		#code
	elsif a>b
		#code
	else
		#code
	end

Para más condiciones `&&` y `||`

####Condicional CASE

	case edad
	when 0,1,2
		#code
	when 3..6
		#code
	when 7..10 then #code
	else
		#code
	end

###Loops

Mientras que ...

	while x<5
		x += 1
	end

Hasta que ...
	
	until x == 5
		x+=1
	end
	
Loop

	loop do
		x += 1
		break if x == 5
	end

For

	for x in(0..4)
		#code
	end

Times

	3.times do
		#code
	end


###Cadenas
	
Las cadenas tambien son objetos		

Letra capital

	"mud".capitalize

Mayúscula, minúscula

	"mud".downcase
	"mud".upcase

	#Intercala 

	"mud".swapcase

Insertar texto

	"mud".insert(0,"Hola ")

Revertir

	"mud".reverse

Cambiar texto

	"mud es gnial".gsub("gnial","genial")
	"mud es gnial".sub("gnial","genial")

Eliminar texto 

	"mud es genial".delete(" ")

Eliminar espacios peligrosos

	"mud es genial  ".strip

Preguntar si tiene un texto o comienza con uno

	"mud es genial".include?("mud")
	"mud es genial".start_with?("m")

Siguiente letra

	"a".next

Para más métodos `"mud".methods`

###Tiempo

	tiempo = Time.now

	tiempo.day
	tiempo.month

###Arreglos

####Iniciando arreglos

	arreglo = [1, "dos", 3.0, true]

	arreglo = [1, "dos", 3.0, true , [1, 2] ]

	otro_arreglo = Array.new

	otro_otro_arreglo = []

####Seleccionando elemento

	arreglo.size
	arreglo[0]
	arreglo.first
	arreglo[-1]

Los primeros 5 elementos desde el número cero

	arreglo[0,5]
	arreglo[0..5]

Seleccionar posición del elemento
	
	heroes.index("Mud")

Preguntar si existe un elemento

	heroes.include?("Mud") 

####Añadiendo elemento

	heroes = []
	heroes[0] = "Mud"
	heroes[12] = "Mud"

	heroes.push("Flash")
	heroes << "Arrow"
	heroes[heroes.size] = "Quicksilver"

	#Mueve a los otros a la derecha
	
	heroes.insert(3,"Spidey")

	#Lo coloca al principio
	
	heroes.unshift("Hulk")

####Métodos para arreglos

Limpiador de nulos (no modifica original)

	heroes.compact

Limpiador de duplicados (no modifica original)

	heroes.uniq

Reversa del arreglo

	heroes.reverse

Ordenar arreglo

	heroes.sort

Une elementos del arreglo separado por un ","
	
	puts heroes.join(",")

####Eliminar elementos

Borrar primero

	heroes.shift

Borrar último

	heroes.pop

Borrar por posición

	heroes.delete_at(1)

Un arreglo sin arreglos internos

	heroes.flatten


###Bloques

	3.times do |x|
		puts #{x}
	end

o también

	3.times{ |x| #code }


Recorrer arreglo (el genial foreach)

	heroes.each do |heroe|
		puts #{heroe}
	end

Recorrer each en reversa

	heroes.reverse_each do |heroe|
		#code
	end

Encontrar

	heroes.find{ |heroe| heroe.length > 4}

Iterar en cadena

	"hola".each_char do |letra|
		#code
	end