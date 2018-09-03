class CommunicatorService

  # def initialize
  # end

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
      "and we'll all be a little sad.",
      border].join.freeze
  end

  def border
    "########################################\n\n".freeze
  end
end