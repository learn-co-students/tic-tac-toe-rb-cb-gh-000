# code your input_to_index and move method here!
def input_to_index(input)
  input_int = input.to_i - 1
end

# move method
def move(board, index, character)
  board[index] = character
end
