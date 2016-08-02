#Guia de Ruby on rails

Rails es un framework de desarrollo de aplicaciones web optimizado para la felicidad del programador y la productividad.

##Configuración

###Instalación

En Windows descargar [RailsInstaller](http://railsinstaller.org/en) , que incluye (02/08/16) Rails 4.2,Bundler,Git,Sqlite,TinyTDS,SQL Server Support,DevKit.

Comprobando versión de rails:

	rails -v

###Creando nuevo proyecto

	rails new mudTest

e instalar las dependencias con la gema `bundler`:

	bundle install

iniciando servidor en `localhost:300`

	rails server


##Primeros Pasos

###Generadores

####Controladores

Crea el controlador `welcome` con la función index

	>También genera una vista
	>También genera una ruta

	rails generate controller welcome index

####Modelos
	
Rail espera que el nombre del modelo sea el singular del nombre de la tabla 

	rails generate model Article title body

A cada campo del la tabla se le coloca su tipo
	
	title:string body:text visits_count:integer	

###Rutas

En el archivo `routes.rb` se guarda la config. de las rutas

El principal:

	root 'welcome#index'

###ERB

Los archivos `.html.erb` admiten etiquetas especiales

Para evaluar código `<% %>`, y para evaluar código e imprimir `<%= %>`

	<% [1,2,3,4].each do |num| %>
		<p>Número: <%= num %></p>
	<% end %>
