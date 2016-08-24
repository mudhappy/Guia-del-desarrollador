#Watir

Instalar gema

	gem install watir

##Primeros pasos

	require 'watir-webdriver'

Navegador

	browser = Watir::Browser.new

>Iniciando: url por defecto, navegador por defecto

	browser = Watir::Browser.start "www.google.com", :firefox

>Ir hacia una url

	browser.goto("www.google.com")

>Regresar

	browser.back

>Cerrar

	browser.close

Screenshots

	browser.screenshot.save("imagen.png")

###Inputs

Textfields

	browser.text_field(:name => "q").set "Ruby on rails"
	browser.text_field(:id => "hola").set "Ruby on rails"

Textareas

	browser.text_field(:name => "q").set "Ruby  \n on \n rails"

Buttons

	browser.button(:name => 'logon').click

Radio buttons

	browser.radio(:value => 'Watir').set
	browser.radio(:value => 'Watir').clear

Check Boxes

	browser.checkbox(:value => 'Ruby').set
	browser.checkbox(:value => 'Python').set
	browser.checkbox(:value => 'Python').clear

Lists Values

>Seleccionando

	browser.select_list(:name => 'entry.6.single').select 'Chrome'

>Limpiando

	browser.select_list(:name => 'entry.6.single').clear

Links

	browser.link(:text => 'Google Forms').click
	browser.link(:href => '/courses').click

Divs & Spans

	browser.div(:class => 'ss-form-desc ss-no-ignore').text

	browser.span(:class => 'powered-by-text').text

Existe?

	.exists?

Se puede setear?

	.set?

Obtener título del website

	puts browser.title

Refresh Website

	sleep(8)
	browser.refresh

Obtener source HTML

	puts browser.html

###Window

Maximizar navegador

	browser.window.maximize

Redimensionar

	browser.window.resize_to(800,600)

Mover

	browser.window.move_to(100,100)

