=begin 

def position_taken?(board, index)
!(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [ [0,1,2], [0,3,6], [0,4,8], [3,4,5], [1,4,7], [2,4,6],[6,7,8], [2,5,8]]
def won?(board)
WIN_COMBINATIONS.detect do |combo|
board[combo[0]] == board[combo[1]] &&
board[combo[1]] == board[combo[2]] &&
position_taken?(board, combo[0])
end
end



def full?(board) # return true when the board is full returns false if it is not
counter=0
co=0
board.each do |k|
if k == " "
return false
end
if k== "X"
counter +=1
else k== "O"
co +=1
end
counter
co
if counter == co
return true
end
end
full?(board)
end

  def draw?(board)
      a = full?(board)
      b = won?(board)
      a && !b

      #full?(board) && !won?(board)

end

def over?(board)
    draw?(board) || won?(board)
end

def winner(board)# returns if it X or O that won
if winning_combo = won?(board)
board[winning_combo.first]
end
end


def turn_count(board)
counter =0

board.each do | boards |
if boards == "X" or boards=="O"
counter +=1
end


end
return counter
end

def current_player(board)
if (turn_count(board) % 2 == 0 )
return "X"
else
return "O"
end
end

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





def current_player(board)
if (turn_count(board) % 2 == 0 )
return "X"
else
return "O"
end
current_player(board)
end



def move( board, index, chare)
board[index]= chare
end

def play(board)
    until over?(board)
        turn(board)
    end

    if won?(board)
        puts "Congratulations #{winner(board)}!"
    else
        puts "Cats Game!"
    end
end





def turn(board)
puts "Please enter 1-9:"
index = gets.strip
ko = input_to_index(index)
if valid_move?( board, ko ) == true
if current_player(board) == "X"
chare= "X"
elsif current_player(board)=="O"
chare= "O"
end
move(board, ko,chare)
display_board(board)
else
turn(board)
end

end

def valid_move?(board, index)
if index.between?(0,8) == false
return false
elsif position_taken?(board, index) == false
return true
end

end
=end 


WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [2,4,6],
    [0,4,8],
]

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
    return input.to_i - 1
end

def position_taken?(board, index)
    !(board[index] == " " || board[index] == "" || board[index] == nil)
end

def valid_move?(board, index)
    index.between?(0,8) && !position_taken?(board, index)
end

def move(board, index, value)
    board[index] = value
end

def turn_count(board)

    counter = 0

    board.each do |position|
        position == "X" || position == "O" ? counter += 1 : nil
    end

    counter
end

def current_player(board)
    turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)

    until valid_move?(board, index)
        puts "Please enter 1-9:"
        input = gets.strip
        index = input_to_index(input)
    end

    move(board, index, current_player(board))
    display_board(board)
end

def won?(board)
    WIN_COMBINATIONS.each do |combination|
        if(combination.all? {|i| board[i] == "X"} || combination.all? {|i| board[i] == "O"})
            return combination
        end
    end

    false
end

def full?(board)
    board.none? {|position| position == " "}
end

def draw?(board)
    a = full?(board)
    b = won?(board)
    a && !b

    #full?(board) && !won?(board)
end

def over?(board)
    draw?(board) || won?(board)
end

def winner(board)
    result = won?(board)

    if result
        board[result[0]]
    else
        nil
    end
end

def play(board)
    until over?(board)
        turn(board)
    end

    if won?(board)
        puts "Congratulations #{winner(board)}!"
    else
        puts "Cats Game!"
    end
end