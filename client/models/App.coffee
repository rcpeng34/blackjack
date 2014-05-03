#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'bust', (hand) =>
      console.log("player busted")
    @get('playerHand').on 'stand', (hand) =>
      @get('dealerHand').playDealer()
    @get('dealerHand').on 'bust', (hand) =>
      console.log("dealer busted")
    @get('dealerHand').on 'stand', (hand) =>
      console.log("now you need to compare")
# on dealer end, check who wins. display message
# @set 'playerHand', deck.dealPlayer() @set 'dealerHand', deck.dealDealer()
