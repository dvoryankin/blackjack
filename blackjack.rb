require './player'
require './card'

class Blackjack
  def initialize
    @cards = Card.new
    @computer = Player.new('Компьютер')
  end

  def start_game
    puts 'Добро пожаловать в игру Блэкджек'
    puts 'Как вас зовут?'
    name = gets.chomp.to_s
    @player = Player.new(name)
    loop do
      prepare_game
      win = false
      loop do
        break if @computer.cards.size == 3 && @player.cards.size == 3
        prepare_game if win == true
        puts "\e[H\e[2J"
        puts '1. Взять карту' if @player.cards.size < 3
        puts '2. Пропустить ход'
        puts '3. Открыть карты'
        game_status(@player)
        game_status(@computer, false)
        choice = gets.chomp.to_i
        case choice
        when 1
          generate_cards(@player, 1)
          step_computer
        when 2
          step_computer
        when 3
          step_computer
          break
        end
      end
      puts "\e[H\e[2J"
      puts"Выиграл: #{who_win}"
      game_status(@player)
      game_status(@computer)
      puts '1. Cыграть ещё раз'
      puts '2. Выход'
      choice = gets.chomp.to_i
      break if choice == 2
    end
  end

  private

  BANK = 20

  def who_win
    plr = @cards.summa_cards(@player.cards)
    cmp = @cards.summa_cards(@computer.cards)
    if plr > 21
      @computer.bank += BANK
      'Компьютер'
    elsif cmp > 21 || plr > cmp
      @player.bank += BANK
      'Игрок'
    elsif cmp == plr
      @player.bank += 10
      @computer.bank += 10
      'Ничья'
    else
      @computer.bank += BANK
      'Компьютер'
    end
  end

  def step_computer
    generate_cards(@computer, 1) if @cards.summa_cards(@computer.cards) < 18 && @computer.cards.size == 2
  end

  def prepare_game
    @player.cards = []
    @computer.cards = []
    @player.bank = 100 if @player.bank.zero?
    @computer.bank = 100 if @computer.bank.zero?
    generate_cards(@player, 2)
    generate_cards(@computer, 2)
    set_rate
  end

  def set_rate
    @player.bank -= 10
    @computer.bank -= 10
  end

  def game_status(plr, show_status = true)
    cards = '|'
    summ = '*'
    puts "Игрок - #{plr.name}"
    puts "Банк - #{plr.bank} ₽"
    plr.cards.each do |card|
      cards += if show_status
                 @cards.print_card(card) + ' |'
               else
                 '*|'
               end
    end
    summ = @cards.summa_cards(plr.cards) if show_status
    puts "Карты: #{cards}"
    puts "Очки: #{summ}"
  end

  def generate_cards(plr, kol)
    count = 0
    while count < kol
      card = @cards.get_card
      unless plr.cards.include?(card)
        plr.cards << card
        count += 1
      end
    end
  end
end
