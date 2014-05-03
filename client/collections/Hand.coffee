class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->
    busted: false

  hit: ->
    @add(@deck.pop()).last()
    if @scores()[0] > 21
      console.log("line 10")
      @bust()

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

  bust: ->
    console.log(@)
    # @set('busted', true)
    @busted = true;
    console.log("line 29")
    @trigger("bust", @)

  stand: ->
    @trigger("stand", @)

  playDealer: ->
    @at(0).flip()
    while @scores()[1] <17 or (@scores()[0]<17 and (not @scores()[1] or @scores()[1]>21))
      @hit()
    if not @busted
      @stand()

  bestScore: ->
    handScores = @scores()
    if handScores[1] > 21 or !handScores[1]
      handScores[0]
    else handScores[1]
