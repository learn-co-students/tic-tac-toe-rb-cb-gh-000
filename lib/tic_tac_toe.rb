  WIN_COMBINATIONS = [
    [0,1,2], #top row
    [3,4,5], #middle
    [6,7,8], #bottom row
    [0,3,6], #left columnt
    [1,4,7], #middle
    [2,5,8],  #right
    [0,4,8], #diagonal left
    [2,4,6] #diagonal right
  ]

  def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(board, index, current_player)
    board[index] = current_player
  end

  def position_taken?(board, location)
    board[location] != " " && board[location] != ""
  end

  def valid_move?(board, index)
    index.between?(0,8) && !position_taken?(board, index)
  end

  def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    player = current_player(board)
    if valid_move?(board, index)
      move(board, index, player)
      display_board(board)
    else
      turn(board)
    end
  end

  def turn_count(board)
    counter = 0;
    board.each do |member|
      if member == "X" || member == "O"
              counter += 1;
      end
    end
    return counter;
  end

  def current_player(board)
  if(turn_count(board) % 2 == 1)
      return "O";
    else
      return "X";
    end
  end

  def won?(board)
    WIN_COMBINATIONS.each do |member|

      position_1 = board[member[0]];
      position_2 = board[member[1]];
      position_3 = board[member[2]];

      if (position_1 == "X" && position_2 == "X" && position_3 == "X")
        return member;
      elsif (position_1 == "O" && position_2 == "O" && position_3 == "O")
        return member;
      end
    end

    return false;
  end

  def full?(board)
    if board.any? { |member| member == " " }
      return false;
    else
      return true;
    end
  end

  def draw?(board)
    if won?(board)
      return false;
    elsif full?(board)
      return true;
    else
      return false;
    end
  end

  def over?(board)
    if draw?(board)
      return true;
    elsif won?(board)
      return true;
    else
      return false;
    end
  end

  def winner(board)
    if draw?(board)
      return nil;
    elsif won?(board)
      member = won?(board)
      grab_letter = member[0];
      return board[grab_letter]
    else
      return nil;
    end
  end

  def play(board)
    while !over?(board)
      turn(board)
      if won?(board)
        break;
      end
    end

    if won?(board)
      puts "Congratulations " + winner(board) + "!"
    else
      puts "Cats Game!"
    end
  end
