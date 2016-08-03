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

###Controladores

Para que se pueda acceder a los datos desde la vista se declaran variable de clase

	@articulos = Article.all

	@articulo = Article.find(params[:id])

###Vista

>Views / articles (se debe crear la carpeta de la vista)
> index.html.erb
> new.html.erb
> show.html.erb

Mostrando solo un articulo en la vista

	<h1><%= @article.title %></h1>
	<div>
		<p><%= @article.body %></p>
	</div>

Iterando articulos en la vista

	<% @articulos.each do |articulo| %>
		<h1><%= articulo.title %></h1>
		<div><%= articulo.body %></div>
	<% end %>


###Rutas

En el archivo `routes.rb` se guarda la config. de las rutas
Las rutas esperan comportamientos

El principal:

	root 'welcome#index'


####Rutas -Avanzados

Verbos de las rutas `get` y `post`

	post 'welcome/index'

>Ejemplo post

	<%= link_to "Recurso con POST", "welcome/index" , method: post %>

Definir el comportamiento de una ruta manualmente

	get "special", to: "welcome#index"

CRUD con rutas

	resources :articles

Significa:

	get "/articles" index
	post "/articles" create
	delete "/articles" delete
	get "/articles/:id" show
	get "/articles/new" new
	get "/articles/:id/edit" edit
	patch "/articles/:id" update
	put "/articles/:id" update

CRUD con rutas con excepciones

	resources :articles, only: [:create,:show]
	resources :articles, except: [:create,:show]

###ERB

Los archivos `.html.erb` admiten etiquetas especiales

Para evaluar código `<% %>`, y para evaluar código e imprimir `<%= %>`

	<% [1,2,3,4].each do |num| %>
		<p>Número: <%= num %></p>
	<% end %>

###Migraciones

Se comportan como pilas, sql sin dolores.

Ejecutan las migraciones

	rake db:migrate

Para quitar la última migración hecha

	rake db:rollback

###Consola Rails

Consola especial donde se ejecutan métodos de rails.

	Article.all

Insertar un articulo

	Article.create(Title:"Segundo articulo", body: "Hola mundo!", visits_count: 0)


###Layout

Si quiero agregar un link o código que influencie en todas las demás, este es el sitio 