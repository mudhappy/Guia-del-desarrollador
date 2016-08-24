##Crear proyecto

Esto crea una carpeta `rsfacilito` con todas las dependencias necesarias del proyecto.

	rails new rsfacilito

Muestra todos los middlewares (Funcionalidades)

	rake middleware

Y corremos el servidor

	rails s

En la ruta `localhost:3000` se muestra una bienvenida

####Creando nuestro index

Para que rails pueda procesar una definimos un ruta y esa manda una peticion al controlador. 

Generando un controlador `Main` con la acción `home`

	rails g controller Main home

La url root es la raiz de `localhost:3000`

	root 'main#home'

En este curso usaremos Haml: una forma de escribir html sin cerrar etiquetas, pero con indentación

	gem "haml-rails"

Renombramos el archivo `home.html.erb` a `home.haml`

##Autentificación Devise

Usaremos la gema devise, del mismo repositorio de github

	gem "devise", github: "plataformatec/devise"

Devise necesita que generemos su instalador

	rails generate devise:install

Y generar el modelo

	rails g devise User

El modelo viene con algunos parametros por default como `email,password,fechas`

Agregamos algunos campos que necesitaremos

	t.string :username, null: false, default: ""
	t.string :name
	t.string :last_name
	t.text :bio

	#Social_networks
	t.string :uid
	t.string :provider  

y corremos la migracion

	rake db:migrate

Ahora ya podemos registrar usuarios 

	localhost:3000/users/sign_in


##Autenticar con facebook

Vamos a [Facebook](https://developers.facebook.com/) para desarrolladores

Agregamos una nueva app website `rsfacilito` y `educación`

Agregamos una extensión de `Devise` : OmniAuth

	gem "omniauth-facebook"

Configurando a omniauth con nuestras crendenciales de Facebook `CONFIG/INITIALIZERS`

	config.omniauth :facebook , "APP_ID", "APP_SECRET"

Agregamos un módulo extra al comportamiento de devise en el modelo

	:omniauthable, :omniauth_providers => [:facebook]

Ahora aparecerá un link de `sign_up for facebook` en la vista 

####Resolviendo redireccionamiento callbacks

En el modelo user se especificar el controlador que recibirá la info de facebook

	devise_for :users, controllers:
  	{
  		omniauth_callbacks: "users/omniauth_callbacks"
  	}

En la configuración de facebook asignamos la url válida

>Valid OAuth redirect URIs

	localhost:3000/users/auth/facebook/callback

Ahora si facebook reconoce nuestro sitio y redirige hacia el callback que asignamos.

####Creando el callback

Creamos la carpeta `users` en `controllers`

y dentro el controlador `omniauth_callbacks_controller.rb` :)

	class Users::OmniauthCallbacksController < ApplicationController
		def facebook
			raise params.to_yaml	
		end	
	end

##Autenticar con facebook parte 2

Los parámetros que nos importan a nosotros son

	def facebook	
		raise params.env["omni_auth"].to_yaml	
	end

Creamos el método de clase en el modelo, para ser usado por el controlador

	def self.del_omniauth

	end	

Si es la primera vez que se logea, lo crea en la base de datos

	def self.del_omniauth
		where(provider: auth[:provider] , uid: auth[:uid]).first_or_create
	end

Creamos un bloque para extraer la información del hash info que contiene `email,usuario,nombre` 

	def self.del_omniauth
		where(provider: auth[:provider] , uid: auth[:uid]).first_or_create do |user|
			if auth[:info]
				user.email = auth[:info][:email]
				user.name = auth[:info][:name]
			end
		end
	end

Para el password creamos números aleatorios (longitud : 20)

	user.password = Devise.friendly_token[0,20] 

Y ya en el controlador creamos el usuario con los parámetros entregados

	@user = User.del_omniauth(request.env["omniauth.auth"])	

Si el usuario ya fue creado anteriormente

	if @user.persisted?
		sign_in_and_redirect @user, event: :authentication
		return
	end

Para que cuando se cierre el navegador siga recordando el login

	@user.remember_me = true

En la vista verificamos si alguien está logeado

	if user_signed_in?
		=link_to "Cerrar sesión", destroy_user_session_path, method: :delete 

##Resolviendo errores de logeo

Cuando facebook no nos da el email

	#user.email = auth[:info][:email]

Al no tener el campo email, Omniauth pide ayuda, algo no sé xd

Creamos al carpeta `users` en la vista, y dentro la carpeta `omniauth_callbacks`

Ahi creamos el archivo `edit.haml`

Este edit servirá para que el usuario pueda completar la información que trató de asignar.

En el OmniAuth_Callback_Controller hago render del form

	render :edit

Archivo `edit.haml` :

Formulario llenado con los datos del usuario y el error

	=form_tag "/custom_sign_up",method: :post do
		%ul
			-@user.errors.full_messages.each do |error|
				%li= error

		%div
			%label{for:"user_name"} Nombre de usuario
			=text_field_tag "user[username]", @user.username
			<input type="text" name="" value="" /> 
		%div
			%label{for:"user_email"} Email de usuario
			=text_field_tag "user[email]", @user.email	
		%div
			%label{for:"user_name"} Nombre
			=text_field_tag "user[name]", @user.name	
		%div
			=submit_tag "Completa registro"	
	
En las rutas asignamos la ruta que recogerá ese Post del formulario

  post "/custom_sign_up", to: "users/omniauth_callbacks#custom_sign_up"

			
En el OmniAuthController definimos esa función

	def custom_sign_up
		
	end

Para que esta funcion acceda a la información de omniauth debemos guardarlo en una variable de sesión

	def facebook
		...
		session["devise.auth"] = request.env["omniauth.auth"]
		...
	end

	def custom_sign_up
		@user = User.del_omniauth(session["devise.auth"])
	end 

###Parámetros fuertes

Evitamos que alguien coloque en el formulario un campo por ejemplo `is_admin` y eso pase a los parámetros y directo la bd D:

	private

		def user_params
			params.require(:user).permit(:name,:username,:email)		
		end

Y ahora al completar los datos de registro actualizamos los datos

	def custom_sign_up
		@user = User.del_omniauth(["devise.auth"])
		#Sin filtrar
			@user.update(params[:user])
		#Datos con parámetros fuertes
			@user.update(user_params)
	end 

###Detallando login

Confirmamos si el usuario completo su registro correctamente, de lo contrario rendereamos el login de nuevo

	if @user.update(user_params)
		sign_in_and_redirect @user, event: :authentication
	else
		render :edit
	end

##Usuarios de prueba app Facebook

Tenemos que tener un método `failure` en el Callback en caso el usuario no autorice xd

	def failure
	end

Y la vista en la carpeta `users/omniauth_callback` -> `failure.haml`

O redireccionar de nuevo al login y darle un aviso

	def failure
		redirect_to new_user_session_path, notice: "Ups, intentalo de nuevo."
	end	

Siendo más específico:

	redirect_to new_user_session_path, notice: "Error: #{params[:error_description]} , Razón: #{params[:error_reason]}"

Para ver la noticia en la vista, editamos el layout `application.html.erb` y solo se mostrará si es que hay una noticia que mostrar

	<body>
	  	<p style="<%= 'display:none;' if notice.nil? && alert.nil?%>"><%= notice %> <%= alert %><p>
	    <%= yield %>
  	</body>

###Rutas para autenticados y no-autenticados

En las rutas se definen métodos para alguien autenticado o no

	authenticated :user do
		root "main#home"
	end

	unauthenticated :user do
		root "main#unregistered"
	end

Definiendo el método unregistered

	def unregistered
		
	end	

Y su vista correspondiente `unregistered.haml` 

Y ponerle un link para que se autentique

	=link_to "Crear cuenta", new_user_registration_path

###SCSS en rails

	background-image: url(#{asset_path("background.jpg")})

###Parciales y helpers

Se usan parciales cuando necesitas copiar el mismo codigo

Ejecutamos un generado de devise para las vistas (Esto genera(muestra) la carpeta `devise` con sus vistas)

	rails g devise:views

En la carpeta `registrations` creamos el parcial `_new.haml` y copiamos el contenido del form `new.html.erb`

	= form_for(resource, as: resource_name, url: registration_path(resource_name)) do |f|
		=devise_error_messages!

		=f.label :email
		=f.email_field :email, autofocus: true

		=f.label :password 
		=f.password_field :password, autocomplete: "off"

		=f.label :password_confirmation
		=f.password_field :password_confirmation, autocomplete: "off"

		=f.submit "Sign up"

Como nos podemos dar cuenta la variable `resource` está sin definir

Es un helper y lo definimos en la carpeta de los helpers `application_helper.rb`

	def resource
		@resource ||= User.new
	end

	def resource_name
		:user
	end

	def resource_class
		User
	end
