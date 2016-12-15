class Card
  def initialize
    @value = %w(2 3 4 5 6 7 8 9 10 V D K T)
    @suits = ['♠', '♣', '♥', '♦']
  end

  def get_card
    suit = rand(3)
    value = rand(12)
    [suit, value]
  end

  def print_card(card)
    "#{@suits[card[0]]} #{@value[card[1]]}"
  end


end
