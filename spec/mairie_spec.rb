require_relative '../lib/mairie'

describe "get_townhall_email" do
  it "should return an email of an url" do
    expect(get_townhall_email(Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/95/avernes.html")))).to eq("mairie.avernes@orange.fr")
  end
end

describe "val_d_oise_town_names" do
  it "should return 185 names" do
    expect(val_d_oise_town_names(Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))).size).to eq(185)
  end
end

describe "emails_val_doise" do
  it "should return the emails of towns with their urls" do
    expect(emails_val_doise(["http://annuaire-des-mairies.com/95/ableiges.html", "http://annuaire-des-mairies.com/95/la-roche-guyon.html"])).to eq(["mairie.ableiges95@wanadoo.fr", "mairie.larocheguyon@wanadoo.fr"])
  end
end

describe "array_of_hash" do
  it "should return an array of Hash" do
    expect(array_of_hash(["AVERNES", "ABLEIGES"], ["avernes@gmail.com","ableiges@gmail.com"])).to eq([{"AVERNES"=>"avernes@gmail.com"}, {"ABLEIGES"=>"ableiges@gmail.com"}])
  end

  it "should return an array size of 185" do
    expect(array_of_hash((0..184), (0..184)).size).to eq(185)
  end
end
