
WIN_COMBINATIONS=[
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
  ]

# Define a method display_board that prints a 3x3 Tic Tac Toe Board
def display_board(board)
 puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end  
def input_to_index(index)
    i=index.to_i()-1
    return i
end
def position_taken?(board,index)
  
  if board[index]==" " || board[index]==""
    return false
  elsif board[index]=="X" ||   board[index]=="O"
    return true
    
  else
    return false
  end
end

def valid_move?(board, index)
  if index>=0 && index<=8 && position_taken?(board,index)==FALSE  
    
    return TRUE
  else
    return FALSE
  end
end  

def move(board,index,val)
  board[index]=val 
end
  
def turn(board)
  puts "Please enter 1-9:"
    val=gets.strip
    index=input_to_index(val)
    player=current_player(board)
    if valid_move?(board,index)==TRUE
      move(board,index,player)
    else
     turn(board)
    end 
   display_board(board)
end




def turn_count(board)
    count=0
  board.each do |val|
     if(val=="X" || val=="O")
       count+=1 
     end 
   end   
  return count   
end

def current_player(board)
    total_turns=turn_count(board)
    if(total_turns%2!=0)
      return "O"
    else 
      return "X"
      
    end
end



def won?(board)
    WIN_COMBINATIONS.each do |win_combo|
      win_index1=win_combo[0]
        win_index2=win_combo[1]
          win_index3=win_combo[2]
          
                    if (board[win_index1]=="X" && board[win_index2]=="X" && board[win_index3]=="X") 
                    return win_combo
                      elsif board[win_index1]=="O" && board[win_index2]=="O" && board[win_index3]=="O"
                      return win_combo
                    end
                end
                 false
end  

def full?(board) 
    board.none? { 
    #returns true if all iterations return false
    |val|
    val==" "
    }
    end  
    
def draw?(board)
  if full?(board)==true && won?(board)==false
  return true
  elsif won?(board)==false&& full?(board)==false
  return false
  end  
end

def over?(board)
 if won?(board)!=false
  return true
 elsif full?(board)==true
 return true
 elsif won?(board)==false && full?(board)==true
  return true
 else 
  return false
end  
end


def draw?(board)
  if full?(board)==true && won?(board)==false
  return true
else
  return false
  end  
end
def winner(board)
        cx=0 
        co=0
        arr=won?(board)
        if arr!=false
          arr.each do |i|
            if board[i]=="X"
              cx+=1
            elsif board[i]=="O"
            co+=1
            end 
        end
        if(cx==3)
        return "X"
      elsif (co==3)
      return "O"
      else
        nil
      end 
      end
       
end 


def play(board)

 until over?(board)==true
 turn(board)
if won?(board)!=false
  puts "Congratulations #{winner(board)}"
elsif draw?(board)
 puts "Cat's game"
end
end
end











