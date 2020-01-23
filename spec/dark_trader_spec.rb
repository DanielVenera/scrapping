require_relative '../lib/dark_trader'

describe "all_currencies_name" do
  it "should return names of currencies" do
    expect(all_currencies_name(Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/")))[0]).to eq("BTC")
    expect(all_currencies_name(Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/")))[1]).to eq("ETH")
  end
  it "should return 200 names of currencies" do
    expect(all_currencies_name(Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))).size).to eq(200)
  end
end

describe "hash_for_currencies" do
  it "should return an Hash" do
    expect(hash_for_currencies(["BTC", "ETH"], ["8373,19","162,35"])).to eq([{"BTC"=>"8373,19"}, {"ETH"=>"162,35"}])
  end

  it "should return an array size of 200" do
    expect(hash_for_currencies((0..199), (0..199)).size).to eq(200)
  end
end
