class CommunicatorService

  def main_menu
    [ border,
      "TICTACTOE OMG OMG\n\n",
      "Whaddaya wanna do? choose one:\n\n",
      "1. Let's get this party started quickly (Player vs. Computer)\n",
      "2. I'm playing with a frined. I mean friend.\n",
      border].join.freeze
  end

  def player_options_menu
    [ border, 
      "This is real easy.\n",
      "Type in two names, separated by a comma:\n",
      "Player X is first, Player O is second\n",
      "Like if you type in 'Lemmy, Aretha', then\n",
      "Player X will be Lemmy and Player O will be Aretha\n",
      "and we'll all be a little sad.\n\n",
      border].join.freeze
  end

  def next_turn(game)
    board = format_board(game.current_board.dup)
    [ board,
      "Your turn, #{game.current_player.name}. Pick a space.\n\n"].join.freeze
  end

  def format_board(board)
    board.each{|k,v| v.nil? ? board[k] = k + 1 : next}
    [ "#{board[0]} | #{board[1]} | #{board[2]}\n", 
      divider,
      "#{board[3]} | #{board[4]} | #{board[5]}\n",
      divider,
      "#{board[6]} | #{board[7]} | #{board[8]}\n"
    ].join
  end

  def game_over(message)
    if message == "draw"
      "Welcome to life: NOBODY WINS"
    else
      "Player #{message} WINS!"
    end

  end

  def border
    "########################################\n\n".freeze
  end

  def divider
    "--------\n".freeze
  end
end