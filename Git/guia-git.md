#Git

Sistema de control de versiones

##Primeros Pasos

Instalando Git:

	sudo apt-get install git

Configuración:

>Nuestro nombre

	config --global user.name "mudhappy"

>Nuestro email

	config --global user.email "mudhappy@hotmail.com"
	
>Mostrar colores en las respuestas

	git config --global color.ui true

Listar toda la configuración

	git config --global --list

	#user.name=mudhappy
	#user.email=mudhappy@hotmail.com
	#color.ui=true

##Nuestro primer proyecto

Para que git empiece a monitorear cambios (solo una vez)

	git init

Estado de nuestro archivos

	git status

Cambiar a estado "listo" a un archivo

	git add index.html

>Cambiar a estado "listo" a todos los archivos

	git add -A

Un punto en el tiempo

	git commit -m "Iniciamos"

Ver los puntos en el tiempo

	git log

>Guardar esos puntos en un .txt

	git log > commits.txt

>Teclas `q` para salir

Viajar en el tiempo entre commits

	git checkout 89181eaf58be698009b3f9e61ee45ca43c2e501d

Viajar al presente

	git checkout master

Borrar puntos en el tiempo

>Borra el commit pero no el código

	git reset --soft 877ef05ae6600e710479c54e476a03fb965b3606

>Borra el commit, borra el codigo

	git reset --hard


##Github

El facebook de coders

Clonar un git 

	git clone https://github.com/jquery/jquery.git


Despues de crear un repositorio en Github

Conéctense, ustedes son el mismo (en la carpeta correspodiente xd)

	git remote add origin https://github.com/mudhappy/gitFacilito.git

Verificando el origen

	git remote -v

>Si borramos el repositorio de Github, entonces removemos el `origin` 

	git remote remove origin
	git remote -v

Enviar archivos a Github (al master)

	git push origin master