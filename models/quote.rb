class Quote
  def self.random_quote
    quotes = File.open('quotes.txt', "r").read.split("\n")
    quotes_length = quotes.length
    random_number = rand(quotes_length)
    quotes[random_number]
  end
end