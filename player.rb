class Player
  attr_accessor :name, :bank, :cards

  def initialize(name)
    self.cards = []
    self.name = name
    self.bank = 100
   end
end
