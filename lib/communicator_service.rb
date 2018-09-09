class CommunicatorService

  def main_menu
    [ border,
      "TICTACTOE OMG OMG\n\n",
      "Whaddaya wanna do? choose one:\n\n",
      "1. Let's get this party started quickly (Player vs. Computer)\n",
      "2. I'm playing with a frined. I mean friend.\n",
      border].join.freeze
  end

  def player_menu_1
    [ border, 
      "Okay, waddaya wanna be called?.\n",
      "(just hit enter if yer fine with a default name\n",
      border].join.freeze
  end

  def player_menu_2
    [ border, 
      "This is real easy.\n",
      "Type in two names, separated by a comma:\n",
      "Player X is first, Player O is second\n",
      "Like if you type in 'Lemmy, Aretha', then\n",
      "Player X will be Lemmy and Player O will be Aretha\n",
      "and we'll all be a little sad.\n\n",
      border].join.freeze
  end

  def computer_turn(position)
    "Computer selects #{position}"
  end

  def next_turn(game)
    board = format_board(game.board)
    [ board,
      "Your turn, #{game.current_player.name}. Pick a space.\n\n"].join.freeze
  end

  def format_board(board)
    display_board = []
    keys = board.positions

    until keys.empty?
      row = keys.shift(board.size)
      row.map!{|k| "#{board.state[k] || k } | " }
      display_board << row.join.chomp("|") << "\n#{divider}"
    end

    display_board.join.chomp(divider)
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
    "----------\n".freeze
  end
end