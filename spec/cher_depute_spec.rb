require_relative '../lib/cher_depute'

describe "deputy_names" do
  it "should return 576 names" do
    expect(deputy_names(Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))).size).to eq(576)
  end
end

describe "deputy_mails" do
  it "should give the email of a given deputy url" do
    expect(deputy_mails(["http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA605036", "http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA721218"])).to eq(["damien.abad@assemblee-nationale.fr", "sylvie.charriere@assemblee-nationale.fr"])
  end
end

describe "deputy_first_name" do
  it "should return the first name of a given first and last name of a man and a woman" do
    expect(deputy_first_name(["Jean Dupont","Jacques Dupont"])).to eq(["Jean","Jacques"])
    expect(deputy_first_name(["Jeanne Dupont","Jeannine Dupont"])).to eq(["Jeanne","Jeannine"])
  end
end

describe "hash_final" do
  it "should return an array of Hashes with first, last names and email" do
    expect(hash_final(["JEAN", "CLAUDE"], ["DUPONT","DURAND"], ["jean.dupont@gmail.com", "claude.durand@gmail.com"])).to eq([{"first_name"=>"JEAN", "last_name"=>"DUPONT", "email"=>"jean.dupont@gmail.com"}, {"first_name"=>"CLAUDE", "last_name"=>"DURAND", "email"=>"claude.durand@gmail.com"}])
  end

  it "should return an array size of 576" do
    expect(hash_final([1,2,3,4,5,6,7,8,9,10],[1,2,3,4,5,6,7,8,9,10], [1,2,3,4,5,6,7,8,9,10]).size).to eq(10)
  end
end
