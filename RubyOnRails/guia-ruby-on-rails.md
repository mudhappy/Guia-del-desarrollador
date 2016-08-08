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

####Active record desde el controlador 
	
Show all

	def show
		@articulos = Article.all
	end

####Show

	def new
		@articulo = Article.find(params[:id])
	end

>o también (Anti SQl inyection)

	Article.where("id = ? OR title = ?",params[:id],params[:title] )

>Método inseguro(Pro sql inyection D:)

	def show
		Article.where("id = #{params[:id]} ")
	end

>Where not

	Article.where.not("id = #{params[:id]} ")

New

	def new
		@articulo = Article.new
	end

Create

	def create
		@articulo = Article.new(title: params[:article][:title], body: params[:article][:body])

		@articulo.save

		redirect_to @articulo
	end

>o también una versión reducida

	@articulo = Article.create(title: params[:article][:title], body: params[:article][:body])
	
	redirect_to @articulo

Para evitar campos sensibles se crea una función privada

	private
	
	def article_params
		params.require(:article).permit(:title, :body)
	end

>Entonces en el create()
	
	@articulo = new (article_params)



>Validando save

	if @articulo.save
		redirect_to @articulo
	else
		#Renderiza 
		render :new
	end

	#Con esto sabemos si es valido (opcional)

	@articulo.invalid?

####Destroy

	def destroy
		@articulo = Article.find(params[:id])
		@articulo.destroy
		redirect_to article_path
	end

####Edit - envia datos a la vista (recogido por el form)

	def edit
		@articulo = Article.find(params[:id])
	end

####Update (se le pasa un hash de datos)

	def update
		@articulo = Article.find(params[:id])
		if @articulo.update(article_params)
			redirect_to @articulo
		else
			render :edit
		end
	end

####Más Active Record

Sql con objetos

Cantidad de registros de una tabla

	Article.all.size
	Article.all.count

Buscar un registro por id

	Article.find(4)

Buscar un registro por otros campos (LIMIT 1)

	Article.find_by(title: "Hola")

Buscar registro con LIKE

	 Article.where("title LIKE ?", "%arti%")

###Modelo

En el modelo se hacen las validaciones

	validates :title, presence: true, uniqueness: true
	validates :body, presence: true	, length: {minimum: 20}

>Más validaciones
	
	#Expresiones regulares
	validates :username, format: {with: /regex/}


###Vistas

>Views / articles (se debe crear la carpeta de la vista)
> index.html.erb
> new.html.erb
> show.html.erb
>...

Mostrando solo un articulo en la vista

	<h1><%= @articulo.title %></h1>
	<div>
		<p><%= @articulo.body %></p>
	</div>

Iterando articulos en la vista

	<% @articulos.each do |articulo| %>
		<h1><%= articulo.title %></h1>
		<div><%= articulo.body %></div>
	<% end %>

####Formularios (vista)

Se le pasa como parametro un objeto del modelo, y cuando se procesa rails deduce:

>Si no existe, crea el registro (create)
>Si existe, lo actualiza

	<%= form_for(@articulo) do |f| %>
		<%= f.text_field :title, placeholder: "Título", class: "form-control" %>
		<%= f.text_area :body, placeholder: "Escribe el artículo" %>
		<%= f.submit "Guardar" %>
	<%end%>

>Este formulario llama a una ruta post (create)

>y más tipos de inputs:

	text_hidden
	password_field
	text_area
	text_field
	email_field
	...


Para capturar un error de formularios

	<% @articulo.errors.full_messages.each do |mensaje| %>
		<div><%= mensaje %></div>
	<% end %>

Método eliminar vista>controlador

	<%= link_to "Eliminar", articulo, method: :delete %>

Método eliminar vista>controlador

	<%= link_to "Editar", edit_article_path(@articulo) %>

####Vistas parciales

Se nombra a una vista parcial con el guión bajo `_form.html.erb`

Como llamar a un parcial

	<%= render "form" %>

Vistas parciales con variables (locales, no globales)

	<%= render "form", name: "Crear" %>

>Se acceden a esas variables locales desde la vista con

	<%= name %>

###Rutas

En el archivo `routes.rb` se guarda la config. de las rutas
Las rutas esperan comportamientos

El principal:

	root 'welcome#index'


####Rutas Avanzadas

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
	delete "/articles/:id" destroy
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

##Autentificación

Instalar la gema `devise` (una de tantas de autentificación)

1. Agregar en el archivo GemFile

	gem "devise"

2. Actualizar dependencias con 
	
	bundle install

Generando controlador de la gema `devise`

	rails generate devise:install

>La gema `devise` trae componentes para validacion por correo, errores de login, entre otros.

Generar el modelo (migración) con el que `devise` va a trabajar

	rails generate devise User

>El modelo es customizable

	t.string :name
	t.string :permission_level 

Generando las vistas

	rails g devise:view

>Esto crea una carpeta `devise` en la vista

Algunos métodos, siendo `user` el nombre del modelo

	if user_signed_in?
		link_to "Logout", destroy_user_session_path, , method: :delete
	end

Login
	
	<%= link_to "Login", new_user_session_path %>

Sign Up
	
	<%= link_to "Sign Up", new_user_registration_path %>
	

User actual (mail)

	<%= current_user.email %>


####Más de Identificación

Unificando users y articles

Generar la migración: La referencia es `user`, por lo tanto se agregará un `user_id` en la tabla articles

	rails generate migration add_user_id_to_articles user:references

Ejecutar la migración

	rake db:migrate

Cambios en el Modelo User: Un usuario tiene muchas ...

	has_many :articles

Cambios en el Modelo Artículo: Un Artículo pertenece a un sólo ...

	belongs_to :user

Y ahora tenemos un nuevo método

	Article.last.user

No olvidar cambiar en el controlador (en el `create`)

>.articles es un método que tiene "current_user" por la llave foránea creada "has_many"

	@articulo = current_user.articles.new(...)

###Callback

Para preveer acciones que necesiten:

####...Haber iniciado sesión (Login)

Una de las ventajas de `devise`, redirige al lugar anterior luego de hacer login 

	before_action :authenticate_user!, only: [:create,:new] 

o también hacerlo manualmente

>Antes de una acción `before` que necesita login

	before_action :validate_user, except: [:show,:index]

>Función "validate_user"

	def validate_user
		redirect_to new_user_session_path, notice: "Necesitas iniciar sesión"
	end

####...la variable @articulo

	before_action :set_article, except: [:index,:new]
	
>Función set_article

	def set_article
		@articulo = Article.find(params[:id])
	end

####...call back en el modelo

Seteando article antes de crearse

	before_create :set_visits_count

>Función set_visits_count

	def set_visits_count
		self.visits_count = 0
	end

Corrección de un campo nulo en la BD

>En el modelo, guardar si es nulo

	self.save if self.visits_count.nil?
	*update ...

>Si es nulo setear a cero

	self.visits_count ||= 0

###Scaffold: CRUD veloz

Generamos el CRUD

>Rake necesario
>Se crea un css *quitar

	rails generate scaffold Comment user:references article:references body:text

###Recursos anidados

Cuando no tiene sentido por si solo, pero si con otro.
Comentarios de un artículo.

>Indicando a la ruta que `comments` es subrecurso de `articles`, la forma de las rutas cambiará

	resources :articles do
    	resources :comments
  	end

>Indicando al modelo la relación (usuario-articulo>comentarios)

	has_many :comments

Rendereando el CommentForm en un artículo

	<h3>Comentarios</h3>
	<%= render "comments/form" %>

Se combina el recurso padre con el recurso hijo en la vista del hijo:

	<%= form_for([@articulo,@comment]) do |f| %>

>Y en el controlador del articulo debemos iniciar el objeto (Show)

	@comment = Comment.new
	
>Y el usuario del controlador del comentario es el usuario actual (Create)

	@comment = current_user.comments.new(comment_params)

>Y el aticulo es el articulo actual

	@comment.article = @articulo;

	#no olvidar  before_action :set_article

>La ruta de dirección también corregir

	redirect_to @articulo

>Llamando a los comentarios a la vista

	<%@articulo.comments.each do |comentario|%>
		<li><b><%=comentario.user.email%> : </b><%=comentario.body%></li>
	<%end%> 