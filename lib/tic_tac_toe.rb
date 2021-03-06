class TicTacToe
  def initialize
    @board = [" "," "," "," "," "," "," "," "," "]
  end

  WIN_COMBINATIONS = [
    # Horizontal rows
    [0, 1, 2], # Top
    [3, 4, 5], # Middle
    [6, 7, 8], # Bottom

    # Vertical rows
    [0, 3, 6], # Left
    [1, 4, 7], # Middle
    [2, 5, 8], # Right

    # Diagonal
    [0, 4, 8], # Left to right
    [2, 4, 6] # Right to left
  ]

  def display_board
    row1 = " #{@board[0]} " + "|" + " #{@board[1]} " + "|" + " #{@board[2]} "
    row2 = " #{@board[3]} " + "|" + " #{@board[4]} " + "|" + " #{@board[5]} "
    row3 = " #{@board[6]} " + "|" + " #{@board[7]} " + "|" + " #{@board[8]} "
    line = "-----------"

    puts row1
    puts line
    puts row2
    puts line
    puts row3
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, character = "X")
    @board[index] = "#{character}"
  end

  def position_taken?(index)
    if @board[index] != " " && @board[index] != "" && @board[index] != nil
      true
    else
      false
    end
  end

  def valid_move?(index)
    if position_taken?(index) || !index.between?(0, 8)
      false
    else
      true
    end
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.chomp
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    count = 0
    @board.each { |pos| pos != " " ? count += 1 : nil }

    count
  end

  def current_player
    turn_count.even? ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.each do |combo|
      if position_taken?(combo[0]) && position_taken?(combo[1]) && position_taken?(combo[2])
        hold = []
        combo.each { |pos| hold.push(@board[pos]) }
        hold.uniq!

        if hold.count == 1
          return combo
        end
      end
    end
    return false
  end

  def full?
    @board.include?(" ") ? false : true
  end

  def draw?
    !won? && full? ? true : false
  end

  def over?
    won? || full? || draw? ? true : false
  end

  def winner
    win = won?
    win ? @board[win[0]] : nil
  end

  def play
    while !over?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
end
