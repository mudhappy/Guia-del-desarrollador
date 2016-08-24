#Guia de Ruby on rails

Rails es un framework de desarrollo de aplicaciones web optimizado para la felicidad del programador y la productividad.

##Configuración

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
	<%= check_box_tag "categories[]", category.id %> <%=category.name%>

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

####Ajax form

Para convertir el formulario en petición Ajax

	<%= form_for([@articulo,@comment], remote: true) do |f| %>
	
	>y enviar mediante Json

	<%= form_for([@article, @comment], remote: true, html:{id: "comments-form", :"data-type" => "json"}) do |f| %>

Código .coffe

	$(document).on "ajax:success", "form#comments-form", (ev,data)->
		console.log "Oh si"
		console.log data
		$(this).find("textarea").val("");
		$("#comments-box").append("<li>#{data.body}</li>");

>Cuidado con las rutas

	before_action :set_comment, only: [:update, :destroy, :show]

>Cuidado con el _comment.json.jbuilder >:c

####JBuilder

En el jbuilder extraemos el datos del user usando el comentario como llave foranea

	json.user do
		json.email @comment.user.email
	end

Y ya podemos mostrarlo por el success ajax .coffe

	data.user.email

###ImageMagick

Descargar desde el [enlace oficial](http://www.imagemagick.org/script/binary-releases.php#windows), comprobando ...

	convert -version

Añadiendo gema al Gemfile (bundle install)

	gem 'paperclip'

Generar migración

	rails g migration add_cover_to_articles

Añadir relación a la migración(rake db:migrate)
	
	add_attachment :articles, :cover

En el modelo del artículo(mismo de aqui arriba)

	has_attached_file :cover

>Añadiendo tamaño de imágenes

	has_attached_file :cover, styles: {medium: "1280x720", thumb: "800x600" , mini: "400x200"}
	#has_attached_file :cover, style: {medium: "1280x720", thumb: "800x600"}

> Añadiendo validación de solo imágenes

	validates_attachment_content_type :cover, content_type: /\Aimage\/.*Z/ 

Añadiendo campo a la vista (_form)

	<%= f.file_field :cover%>

>No olvidar agregarlo a los parámetros del controlador

	def article_params
		params.require(:article).permit(:title, :body, :cover)
	end

En la vista del aticulo (Show)

	<%= image_tag @article.cover.url() %>

>(Ver instalación de File)[https://github.com/thoughtbot/paperclip#file] necesario para Windows

###Categorias

	rails g scaffold Category name color

Añadiendo validacion al modelo

	validates :name, presence: true

Cambiando a color la vista 

	<%= f.color_field :color %>

Application controller es el lugar perfecto para poner comportamientos ue se comparten entre todos los controladores

	before_action :set_categories
	private

	def set_categories
	  	@categories = Category.all
	end

En la vista

	<% @categories.each do |category| %>
		<li><%= category.name %></li>
	<%end%>

####Creando Tabla muchos a muchos

Creando modelo (rake db:migrate)

	rails g model HasCategory article:references category:references

Para convertir las categorias en un arreglo para pasarlo por el form

	<%=check_box_tag "categories[]", category.id%> <%=category.name%>

Y especificarlo en el controlador

	@article.categories = params[:categories]
	

>No olvidar agregarlo al controlador (_params)
	
	params.require(:article).permit(:title, :body, :cover, :categories)

En el modelo article seteamos las categorias

	def categories=(value)
		@categories = value
	end 

Para tener un callback y guardar

	after_create :save_categories

	def save_categories
		@categories.each do |category_id|
			HasCategory.create(category_id: category_id, article_id: self.id)
		end
	end

Relacionando en el modelo Category (Muchos a Muchos) 

	has_many :has_categories
	has_many :articles, through: :has_categories

Ahora si se puede mostrar los articulos en la vista de las categorias

	<%@category.articles.each do |article|%>
		<li><%= link_to article.title, article %></li>
	<%end%>

>Tambien se relaciona en el modelo Article

	has_many :has_categories
	has_many :categories, through: :has_categories
	
###Cambiando Tablas por Migrations

La columna permission_levels deberia ser Integer, no String

Entonces generamos la migración y: 

	def change
		remove_column :users, :permission_level, :string
		add_column :users, :permission_level, :integer, default: 1
	end

###Concern

Esos ajustes,métodos que queremos presente en todo el grupo de modelos o controladores

Creamos un .rb en la carpeta concern correspondiente

	permisions_concern.rb

Creamos los métodos

	module PermisionsConcern
		extend ActiveSupport::Concern
		def is_normal_user?
			self.permission_level >= 1
		end	

		def is_editor?
			self.permission_level >= 2
		end	

		def is_admin?
			self.permission_level >= 3
		end	
	end

Y por ejemplo incluimos el método en el modelo User

	include PermisionsConcern

Usando el concern en otro lugar (ApplicationController)

	def authenticate_editor!
		redirect_to root_path unless user_signed_in? && current_user.is_editor?
	end

	def authenticate_admin!
		redirect_to root_path unless user_signed_in? && current_user.is_admin?
	end

Validando en el ArticleController

	before_action :authenticate_editor!, only: [:new,:create,:update]
	before_action :authenticate_admin!, only: [:destroy]

>Actualizando campo rails console

	User.last.update_attributes(permission_level: 3)

###AASM

Crea migracion de agregar columna estado a los articulos

	rails g migration add_column_state_to_articles state

>Migración

	add_column :articles, :state, :string, default: "in_draft"

Agregamos la gema al Gemfile (bundle install)

	gem 'aasm'

Para que nuestro modelo Article pueda hacer uso de la maquina de estados

	include AASM

La columna que afectaremos será

	aasm column: "state" do
			
	end

Creamos las transiciones de los eventos

	aasm column: "state" do
		state :in_draft, initial: true
		state :published

		event :publish do
			transitions from: :in_draft, to: :published
		end

		event :unpublish do
			transitions form: :published, to: :in_draft
		end
	end

Cambiando estado desde la consola

	Article.last.publish!

####Scopes

	scope :publicados, ->{where(state: "published")}
	#scope :publicados, ->{Article.where(state: "published")}

o también

	def self.publicados
		Article.where(state: "published")
	end

>Más scopes

	scope :ultimos, ->{order("created_at DESC").limit(10)}
	
Usando scopes (controlador Article)

	def index
		@articles = Article.publicados.ultimos
	end

###Dashboard

Agregando ruta `welcome#dashboard`

  get "/dashboard", to: "welcome#dashboard"

Agregando método al controlador Welcome
	
	def dashboard
  	
  	end

Agregando vista `dashboard.html.erb` a la carpeta welcome

En el controlador designamos que solo el admin puede usar ese método

	before_action :authenticate_admin!, only: [:dashboard]

En la ruta, colocamos la acción con `put` 

  put "/articles/:id/publish", to: "articles#publish"

Necesitamos crear el método `publish` en el controlador Article

	def publish
	end

>Y que solo el admin pueda acceder a ese método

	before_action :authenticate_admin!, only: [:destroy,:publish]
	
Método publish

	@article.publish!
	redirect_to @article

Enlace para Publicar artículo en la vista (each)

	<%= link_to "Publicar", "/articles/#{article.id}/publish", method: :put %>

Solo se mostrarán en los artículos que pueden ser publicados

	<%if article.may_publish?%>
		#code
	<%end%>

###Paginación

Instalamos la gema

	gem 'will_paginate'

En el controlador del Article

	@articles = Article.publicados

A esto:

	@articles = Article.paginate(page: params[:page], per_page:5).publicados

Agregando paginación a la vista

	<%= will_paginate @articles %>