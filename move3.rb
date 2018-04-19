class Board
    attr_accessor :board
    # Dans la classe Board, on créer 9 nouvelles instances de la classe Boardcase pour constituer le plateau de jeu
    def initialize
        @case_1 = BoardCase.new(" ", 1)
        @case_2 = BoardCase.new(" ", 2)
        @case_3 = BoardCase.new(" ", 3)
        @case_4 = BoardCase.new(" ", 4)
        @case_5 = BoardCase.new(" ", 5)
        @case_6 = BoardCase.new(" ", 6)
        @case_7 = BoardCase.new(" ", 7)
        @case_8 = BoardCase.new(" ", 8)
        @case_9 = BoardCase.new(" ", 9)
    # On mets ces instances dans un array

        @board = [@case_1,@case_2,@case_3,@case_4,@case_5,@case_6,@case_7,@case_8,@case_9]
    end

    # On créer la méthode d'affichage du board sur le terminal
    def display_board

      puts " #{@board[0].value} | #{@board[1].value} | #{@board[2].value} "
      puts "-----------"
      puts " #{@board[3].value} | #{@board[4].value} | #{@board[5].value} "
      puts "-----------"
      puts " #{@board[6].value} | #{@board[7].value} | #{@board[8].value} "

    end
    # La méthode play permet de changer les valeur des boardcases selon le choix des joueurs
    def play(players_choices)
        ObjectSpace.each_object(BoardCase) { |boardcase|
            ObjectSpace.each_object(Player) { |player|
            # On appel les instances des classes player et boardcase
                players_choices.each { |position|

                    if boardcase.value == " "
                        if boardcase.position == position
                            boardcase.value = player.value
                            # pour chaque élément, on contrôle la position du boardcase et le nom du player puis on modifie la valeur du boardcase selon la valeur du joueur
                        end
                    end

                }
            }
        }

    end

end

class BoardCase
    attr_accessor :value, :position
    # Dans la classe Boardcase, on créer la méthode initialize qui attribut à chaque instance de la classe une valeur et une position
    def initialize(value, position)
        @value = value
        @position = position
    end
end

class Player
    attr_accessor :value, :win
    # Dans la classe Play, on créer la méthode initialize qui attribut à chaque instance de la classe ses paramètres (nom, valeur et statut)
    def initialize
        @win = win
    # On demande au joueur quel symbole il veut être
        puts "Vous voulez être X ou O ? "
        value = gets.chomp.upcase
        if value == "X" || value == "O"
            @value = value

        end

    end
end

class Game
    # cette classe contiendra tout le fonctionnement du jeu
    attr_accessor :player_1, :player_2, :board
    def initialize
        @player_1 = Player.new
        @player_2 = Player.new
        @board = Board.new
        @players = []
        @players.push(@player_1, @player_2)
    end

    def turn
        i = 0
        @players_choices = []
        # Il y a au maximum 9 tour, donc on continu dans que i est inf. à 9
        while i < 9
            @players.each { |player|

                @board.display_board
                # Pour chaque tour, on affiche le board, on adresse un message au joueur lui demandant où placer son pion
                puts "Choisi une case entre 1 et 9"
                choix = gets.chomp.to_i
                unless choix == 1 || choix == 2 || choix == 3 || choix == 4 || choix == 5 || choix == 6 || choix == 7 || choix == 8 || choix == 9
                    puts "Try again"
                    choix = gets.chomp.to_i
                end

                # on enregistre dans le tableau crée plus tôt nos choix
                @players_choices.push(choix)
                @board.play(@players_choices)
                # On appel la méthode play

                i += 1
                if i == 9
                    puts "C'est fini!"
                break
                # On arrête le jeu une fois arrivé à 9 choix
                end
            }
        end
    end
end

# On lance le jeu
Game.new.turn
