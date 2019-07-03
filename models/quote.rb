class Quote
  class << self
    def random_quote
      quotes_length = quotes.length
      random_number = rand(quotes_length - 6) + 6
      quote_with_color(quotes[random_number])
    end

    def quotes
      @quotes ||= File.open('quotes.txt', "r").read.split("\n")
    end

    def quote_with_color(quote)
      quote_hash = {}
      quote_array = quote.split('***')
      quote_hash['text'] = quote_array[0]
      quote_hash['color'] = color_prermitted?(quote_array[1]) ? quote_array[1] : 'blue'
      quote_hash
    end

    def color_prermitted?(color)
      %w[red blue yellow black green springgreen orangered].include?(color)
    end
  end
end
