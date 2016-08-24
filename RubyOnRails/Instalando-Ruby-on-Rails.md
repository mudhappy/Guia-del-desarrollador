#Instalación

##En Linux (Ubuntu)

De la página oficial de [rmv](https://rvm.io/)

Preparar el sistema

	sudo apt-get update

>Instalar curl
	
	sudo apt-get install curl

Primero aseguramos la conexion? xd

	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

Install rvm  y ruby

	\curl -L https://get.rvm.io | bash -s stable --ruby

..y rails

	\curl -L https://get.rvm.io | bash -s stable --rails

Guia de [Gemset](https://platzi.com/blog/introduccion-ruby-on-rails/) y (Gemset avanzado)[https://platzi.com/blog/gemsets-con-rvm/]

Instalar Ruby en rvm

	rvm install ruby

-Le decimos a RVM cual versión de Ruby queremos usar:

	rvm use 2.2.0

-Listamos las distintas versiones de Ruby que tenemos:

	rvm list

Crear un gemset

	rvm gemset create misgemas

-Le decimos a RVM que trabajaremos con este Gemset:

	rvm 2.2.0@misgemas

Listar los gemsets

	rvm gemset list_all

Borrando un gemset

	rvm gemset delete @gemsetPrueba1

Desinstala la versión de Ruby especificada.

	rvm uninstall 2.2.0

>y la documentación tambien

	rvm remove 2.2.0

Renombrar Gemset

	rvm gemset rename misgemas gemasFacilito


Ojo con el ..

	You need to change your terminal emulator preferences to allow login shell.
Sometimes it is required to use `/bin/bash --login` as the command.


##En Windows

En Windows descargar [RailsInstaller](http://railsinstaller.org/en) , que incluye (02/08/16) Rails 4.2,Bundler,Git,Sqlite,TinyTDS,SQL Server Support,DevKit.

Comprobando versión de rails:

	rails -v