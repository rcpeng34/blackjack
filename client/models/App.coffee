#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @newGame()

  newGame: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'bust', (hand) =>
      @playerLoses()
    @get('playerHand').on 'stand', (hand) =>
      @get('dealerHand').playDealer()
    @get('dealerHand').on 'bust', (hand) =>
      @playerWins()
    @get('dealerHand').on 'stand', (hand) =>
      @checkScores()

    @trigger('newGame', @)

  playerWins: ->
    alert "You win, play again"

  playerLoses: ->
    alert "You lose, play again"

  playerPushes: ->
    alert "You pushed, play again"

  checkScores: ->
    @playerWins() if @get('playerHand').bestScore() > @get('dealerHand').bestScore()
    @playerLoses() if @get('playerHand').bestScore() < @get('dealerHand').bestScore()
    @playerPushes() if @get('playerHand').bestScore() == @get('dealerHand').bestScore()

  # checkHands: -> #compares dealer and player hand
  # processResults: -> #used later once you put in betting

# on dealer end, check who wins. display message
# @set 'playerHand', deck.dealPlayer() @set 'dealerHand', deck.dealDealer()
