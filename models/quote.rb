class Quote
  class << self
    def random_quote
      quotes_length = quotes.length
      random_number = rand(quotes_length)
      quotes[random_number]
    end

    def quotes
      @quotes ||= File.open('quotes.txt', "r").read.split("\n")
    end
  end
end
