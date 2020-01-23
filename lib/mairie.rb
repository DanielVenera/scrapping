require 'nokogiri'
require 'open-uri'

def principal_page
  return Nokogiri::HTML(open("http://annuaire-des-mairies.com/"))
end

def get_townhall_email(townhall_url)
  townhall_adress = townhall_url.xpath('//td[contains(text(), "@")]')
  return townhall_adress.text
end

def avernes
  Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/95/avernes.html"))
end

def val_d_oise
  Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
end

#URLs des villes du Val d'Oise : Prend l'url du Val d'Oise et renvoit un array des urls des villes du Val d'Oise
def get_townhall_urls(townhall_urls)
  townhall_urls = townhall_urls.xpath('//a[contains(@class,"lientxt")]')
  townhall_urls = townhall_urls.map {|element| element["href"]}
  townhall_urls.map!.each do |suppress_the_point_and_add_begin|
    "https://www.annuaire-des-mairies.com" + suppress_the_point_and_add_begin[1..-1]
  end
  return townhall_urls
end

#Noms des villes du Val d'Oise : Prend l'url du Val d'Oise et en ressort les noms des villes sur l'url
def val_d_oise_town_names(a)
    town_names = a.xpath('//a[contains(@class,"lientxt")]')
    b = []
    town_names.each do |name|
      b << name.text
    end
    return b
end

#Emails des villes du Val d'Oise : Prend toutes les urls des villes du val d'oise et ressort toutes les adresses mails de chaque url
def emails_val_doise(townhall_urls)
c = []
  townhall_urls.map.each do |un_par_un|
    b = Nokogiri::HTML(open(un_par_un))
    un_par_un = b.xpath('//td[contains(text(), "@")]')
    c << un_par_un.text
  end
    return c
end

# créé un hash avec k = noms de la ville et v = adresse mail de la ville
def array_of_hash(a, b)
  c = Hash[a.zip(b)]
  d = []
  c.each do |e, f|
    d << {e => f}
  end
  return d
end
