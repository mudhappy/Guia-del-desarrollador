#Nokogiri

	gem install nokogiri

##Primeros pasos

	require 'nokogiri'
	require 'open-uri' #Cuando se parsea internet xd

La página que abrimos ...

	html = open("https://news.ycombinator.com/")

... la parseamos con Nokogiri

	doc = Nokogiri::HTML.parse(html)
	doc = Nokogiri::HTML.parse(html, nil, 'utf-8') #con utf-8

>Tambien podemos parsear codigo (es lo mismo)

	doc = Nokogiri::HTML.parse("<html><body><h1>Mr. Belvedere Fan Club</h1></body></html>")

Búqueda

	doc.search(".title").map do |element|
		puts element.inner_text
	end

	doc.css('section.white a').map |element|
		puts element['href']
	end

>solo el primero

	doc.css('li')[0].text

	page.css("li[data-category='news']")

Un div con id

	page.css('div#funstuff')[0]

Un enlace de un div

	page.css('div#reference a')

Ejemplo

	news_links = page.css("a[data-category=news]")
	news_links.each{|link| puts link['href']}