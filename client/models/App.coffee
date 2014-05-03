#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'playerChips', 100
    @newGame()

  newGame: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'currentBet', 10
    @set 'playerChips', @get('playerChips') - @get('currentBet')

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
    @set 'playerChips', @get('playerChips') + @get('currentBet') * 2
    @trigger('gameEnded', @)
    alert "You win, play again"

  playerLoses: ->
    @trigger('gameEnded', @)
    alert "You lose, play again"

  playerPushes: ->
    @set 'playerChips', @get('playerChips') + @get('currentBet')
    @trigger('gameEnded', @)
    alert "You pushed, play again"

  checkScores: ->
    @playerWins() if @get('playerHand').bestScore() > @get('dealerHand').bestScore()
    @playerLoses() if @get('playerHand').bestScore() < @get('dealerHand').bestScore()
    @playerPushes() if @get('playerHand').bestScore() == @get('dealerHand').bestScore()

  # checkHands: -> #compares dealer and player hand
  # processResults: -> #used later once you put in betting

# on dealer end, check who wins. display message
# @set 'playerHand', deck.dealPlayer() @set 'dealerHand', deck.dealDealer()
