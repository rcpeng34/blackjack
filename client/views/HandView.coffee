class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    # if there's an ace and sum2 <= 21, show it
    secondScore = @collection.scores()[1]
    secondScoreText = if secondScore and secondScore <= 21 then " or " + secondScore else ""
    @$('.score').text @collection.scores()[0] + secondScoreText

