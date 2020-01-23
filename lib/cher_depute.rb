require 'nokogiri'
require 'open-uri'

def page
  Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
end

#OK! URLs de chaque députés : Prend l'url de l'Assemblée et renvoit un array des urls des villes du Val d'Oise
def deputy_urls(a)
  a = a.xpath('//a[contains(@href,"/deputes/fiche/")]')
  a = a.map {|element| element["href"]}
  a.map!.each do |add_url_begin|
    "http://www2.assemblee-nationale.fr/" + add_url_begin
  end
  return a
end

#Emails des députés : Prend toutes les urls des députés et ressort toutes les adresses mails de chaque url
def deputy_mails(a)
  c = []
  a.each do |un_par_un|
    b = Nokogiri::HTML(open(un_par_un))
    d = b.xpath('//a[contains(@class, "email")]').remove.xpath('//a[contains(text(), "@")]').text
    c << d
  end
  return c
end

#Noms des députés : Prend l'url de l'assemblee nationale et en ressort les prénoms et noms des députés, dans deux arrays différents
def deputy_names(a)
    b = a.xpath('//a[contains(@href,"/deputes/fiche/")]')
    c = []
    b.each do |name|
      if name.text.include?("Mme ") then
        a = name.text[4..-1]
      else
        a = name.text[3..-1]
      end
      c << a
    end
    return c
end

#PRENOM
def deputy_first_name(a)
  first_name = []
  a.each do |separe_first_name|
    b = separe_first_name.split(' ')
    first_name << b[0]
  end
  return first_name
end

#NOM
def deputy_last_name(a)
  last_name = []
  a.each do |separe_last_name|
    b = separe_last_name.split(' ')
    last_name << b[1..-1].join(' ')
  end
  return last_name
end

def hash_final(a,b,c)
  d = []
  e = -1
  a.size.times do
    e += 1
    d << {"first_name" => a[e], "last_name" => b[e], "email" => c[e]}
  end
  return d
end

def perform
  a = page
  b = deputy_urls(a)
  c = deputy_mails(b)
  d = deputy_names(a)
  e = deputy_first_name(d)
  f = deputy_last_name(d)
  hash_final(e,f,c)
end
