require_relative 'Player'
require_relative 'MathQuestion'

class MathGame
  def initialize
    @players = [Player.new('Player 1'), Player.new('Player 2')]
    @current_player_index = 0
  end

  def start_game
    until game_over?
      puts '----- NEW TURN -----'
      current_player = @players[@current_player_index]
      math_question = MathQuestion.new
      puts "#{current_player.name}: #{math_question.question}"
      answer = gets.chomp.to_i
      if answer == math_question.answer
        puts "#{current_player.name}: YES! You are correct."
      else
        puts "#{current_player.name}: Seriously? No!"
        current_player.lose_life
      end
      display_scores
      switch_player
    end
    announce_winner
  end

  def game_over?
    @players.each do |player|
      return true if !player.alive?
    end
    false
  end

  def display_scores
    @players.each do |player|
      puts "#{player.name}: #{player.lives}/3"
    end
  end

  def switch_player
    @current_player_index = (@current_player_index + 1) % @players.length
  end

  def announce_winner
    winner = nil
    loser = nil

    @players.each do |player|
      if player.alive?
        winner = player
      else
        loser = player
      end
    end

    puts "#{winner.name} wins with a score of #{winner.lives}/3"
    puts '-------- GAME OVER --------'
    puts 'Goodbye!'
  end
end
