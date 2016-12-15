require './player'
require './card'

class Blackjack

  def initialize
    @cards = Card.new
    @computer = Player.new('Компьютер')
  end

  def start_game
    puts "Let's play BlackJack!"
    enter_name
    loop do
      prepare_game
       case game_choice
        when 1
        break unless enough_money?
        after_start
        choice = menu
        case choice
        when 1
          player_skip_turn
        when 2
          player_choose_take_card
        when 3
          end_game
        end
      when 0
        break
      else
        puts 'Введите 1 или 0'
      end





    end
  end

  def enter_name
    @name ||= ''

    while @name.empty?
      puts "Please enter your name?"
      @name = gets.chomp.capitalize
      puts "Hello #{@name}!"
    end
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







end






