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

	puts "La suma de 1 + 2 es #{1+2}"


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

####Función LEVEL 2.1 , *textos es un arreglo

	def saludo(texto,*textos)
		return texto
	end

	puts saludo("Hola","como","estas")

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

o también (MODO LIGHT)

	puts "soy genial" if #code

#####Condicional UNLESS (A menos que)

	unless a == b 
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

>Tip: No te gustan las comillas?

	%w[1 "dos" 3.0 true]

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
		puts "#{heroe}"
	end

Recorrer each en reversa

	heroes.reverse_each do |heroe|
		#code
	end

Find (internamente es un each), regresa primer valor que cumpla condición

	heroes.find{ |heroe| heroe.length > 4}
	heroes.find{ |heroe| heroe.include?("w") }

Iterar en cadena

	"hola".each_char do |letra|
		#code
	end

###Hashes y símbolos

####Hashes

	heroes = 
	{
		"mud" => 20,
		"flash" => 350,
		"arrow" => 200
	}

####Símbolos

Optimizan, no son objetos.

	heroes = 
	{
		:mud => 20,
		:flash => 350,
		:arrow => 200
	}

Agregando elementos

	heroes[:superman] = 1500

Seleccionando elementos

	menu[:mud]

####Avanzado

Devuelve valores [20,350,200]

	heroes = 
	{
		:mud => 20,
		:flash => 350,
		:arrow => 200
	}

	heroes.values

Iterar hashes

	heroes.each{|key,value| puts "#{key} - #{value}" }

Convertir un arreglo en hash

	heroes = ["mud","flash","arrow","superman","wonder woman"]
	
	nuevo_hash = heroes.group_by do |heroe|
		heroe.length
	end

devuelve:

	{
		3=>["mud"],
		5=>["flash","arrow"],
		8=>["superman"],
		12=>["wonder woman"]
	}

###Map

Utiliza each internamente para iterar.

	heroes.map do |heroe|
		heroe.downcase
	end

o también:

	(1..5).map{|i| i*20 }

o también

	heroes.map do |key,value|
		puts key
	end

###Collect

Transforma elementos de un arreglo

	["a","b","c"].collect do |letra|
		letter.capitalize
	end

otra forma

	(1..4).collect{"cat"}

###Objetos

El objeto más básico en Ruby

	mud = Object.new

Con funciones propias

	def mud.ataca
		#code
	end

	mud.ataca

###Archivos

Para solo lectura `r`

Para solo escritura `w`	

Para lectura y escritura `w+`	

Para lectura `a`	

Abriendo archivo

	f = File.open("tweets.txt","r")

Lectura del archivo

	f.each do |linea|
		puts "#{linea}"
	end

o también (abertura y lectura)

	File.readlines("tweets.txt").each do |linea|
		puts "#{linea}"
	end

Obteniendo Numlinea de cada linea del archivo `each_with_index`

	File.readlines("tweets.txt").each_with_index do |value,key|
		puts "Key: #{key} -> #{value}"
	end

Escribiendo en un archivo

	heroes = ["Mud","Flash","Batman"]

	File.open("text.txt","w+") do  |archivo|
		heroes.each{|heroe| puts archivo.puts(heroe) }
	end

###Argumentos

Estos argumentos se pasan en consola

	ruby rubyfile.rb tweets.txt

y en el archivo se captura 

	ARGV[0]
	ARGV[1]



###Clases e instancias

Se define asi

	Class heroe
		#code
	end

Se crea asi

	mud = heroe.new

	>Inspeccionar un objeto
	mud.inspect

Método constructor

Cuando se crea un objeto, este wey se ejecuta primero.

	...
	def initialize
		#code
	end
	...

o también

	...
	def initialize(name,level)
		@name,@level = name,level
	end
	...	
	me = Heroe.new("Mud",9000)

Definiendo atributos y métodos

>GET

	def ataque
		120
	end

>SET
	
	def ataque(str)
		@ataque = str
	end

Atributos/Métodos de clase

	@@all = []

GET

	def self.all
		@@all
	end

SET

	@@all << self

####Macros

Mejor forma de definir atributos

>Solo lectura

	attr_reader: :especial

>Solo escritura

	attr_writer: :mana

>Ambos

	#attr_accesor: :nombre, :level

###Herencia

Hereda métodos de otra clase

>Clase Padre

	Class meta_human
		def initialize
			puts "soy un pinche meta humano"
		end
	end

>Clase hija

	Class heroe < meta_human
		attr_accesor: username
	end

>Peligro de sobreescritura?, llamamos al método de la superclase con `super` 
	
	def self.description
		#super()
		super
		#code
	end


La clase `heroe` hereda todos los métodos y atributos de un `meta humano`

	flash = heroe.new
	flash.username = "@TheFlash"


###Módulos

Paquetes de métodos para re usar.

	module MiModulo
		def saludo
			#code
		end
	end

Para incluir un módulo

	class Test
		include MiModulo
		include Enumerator
		...

	end


##Gemas

####Cómo instalar gemas en Windows

1. Descargar el DevKit [página oficial](http://rubyinstaller.org/downloads/)

2. Extrar el archivo en una ruta sin espacios

3. Seguir los pasos de su [documentación](https://github.com/oneclick/rubyinstaller/wiki/Development-Kit)

		cd C:/DevKit

		ruby dk.rb init

		ruby dk.rb install

4. Instalar la gema :')'

		gem install twitter

####Archivo Gemfile(necesario para ciertas gemas con dependencia)

Aqui se especifica las gemas del proyecto

	gem "twitter"

Archivo GemFile.lock
Gemas que necesitan mis gemas.

>Necesaria la gema bundler
	
	gem install bundler

>Creando .lock

	bundle install
	

####Usando una gema

Cada gema tiene su propia documentación

Para usarla:

	require "twitter" 

	