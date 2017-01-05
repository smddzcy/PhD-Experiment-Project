MuserrefDirective = ->
  restrict: 'E'
  replace: true
  templateUrl: 'img/muserref.svg'
  link: (element, attributes, scope) ->
    $(attributes[0]).addClass 'responsive-img'

MarvinDirective = ->
  restrict: 'E'
  replace: true
  templateUrl: 'img/marvin.svg'
  link: (element, attributes, scope) ->
    $(attributes[0]).addClass 'responsive-img'

MuhittinDirective = ->
  restrict: 'E'
  replace: true
  templateUrl: 'img/muhittin.svg'
  link: (element, attributes, scope) ->
    $(attributes[0]).addClass 'responsive-img'

SukufeDirective = ->
  restrict: 'E'
  replace: true
  templateUrl: 'img/sukufe.svg'
  link: (element, attributes, scope) ->
    $(attributes[0]).addClass 'responsive-img'

NurdaneDirective = ->
  restrict: 'E'
  replace: true
  templateUrl: 'img/nurdane.svg'
  link: (element, attributes, scope) ->
    $(attributes[0]).addClass 'responsive-img'

HayriyeDirective = ->
  restrict: 'E'
  replace: true
  templateUrl: 'img/hayriye.svg'
  link: (element, attributes, scope) ->
    $(attributes[0]).addClass 'responsive-img'

AyseDirective = ->
  restrict: 'E'
  replace: true
  templateUrl: 'img/ayse.svg'
  link: (element, attributes, scope) ->
    $(attributes[0]).addClass 'responsive-img'

DijkstraDirective = ->
  restrict: 'E'
  replace: true
  templateUrl: 'img/dijkstra.svg'
  link: (element, attributes, scope) ->
    $(attributes[0]).addClass 'responsive-img'

StoneDirective = ->
  restrict: 'E'
  replace: true
  templateUrl: 'img/stone.svg'
  link: (element, attributes, scope) ->
    $(attributes[0]).addClass 'responsive-img'

SwampDirective = ->
  restrict: 'E'
  replace: true
  templateUrl: 'img/swamp.svg'
  link: (element, attributes, scope) ->
    $(attributes[0]).addClass 'responsive-img'

BugService = ($compile, $rootScope, Constants) ->
  MOVING_BUGS = [
    "<sukufe></sukufe>",
    "<muhittin></muhittin>",
    "<marvin></marvin>",
    "<muserref></muserref>"
  ]
  STATIONARY_BUGS = [
    "<hayriye></hayriye>",
    "<ayse></ayse>",
    "<nurdane></nurdane>",
    "<dijkstra></dijkstra>"
  ]
  BG_ITEMS = [
    "<stone></stone>",
    "<swamp></swamp>"
  ]
  bugNumber = 0 # Current bug number

  Bug =
    getNextElements: ->
      rand = Math.floor Math.random() * MOVING_BUGS.length

      movingBugDomEl = $compile(MOVING_BUGS[rand])($rootScope.$new())
      stationaryBugDomEl = $compile(STATIONARY_BUGS[rand])($rootScope.$new())
      bgItemDomEl = $compile(BG_ITEMS.random())($rootScope.$new())

      return {
        movingBug: movingBugDomEl
        stationaryBug: stationaryBugDomEl
        bgItem: bgItemDomEl
        bugNumber: rand
      }

    setInitialPositions: (movingBug, stationaryBug, bgItem, away = false) ->
      bgItemPositions =
        'top left':
          transform: 'translateX(-200%)'
          top: 0, left: 0
        'top right':
          transform: 'translateX(-300%)'
          top: 0, left: '100%'
        'bottom left':
          transform: 'translate(-200%, -50%)'
          top: '100%', left: 0
        'bottom right':
          transform: 'translate(-300%, -50%)'
          top: '100%', left: '100%'

      switch [0...4].random()
        when 0 # Top left
          switch [0...3].random()
            # Horizontal, to top right
            when 0
              possibleBgItemPos = ['bottom left', 'bottom right']

              stationaryBug.css
                transform: 'translateX(-200%) rotate(0deg)'
                top: 0, left: '100%'

              unless away
                movingBug.css
                  transform: 'rotate(180deg)'
                  top: 0, left: 0
              else
                movingBug.css
                  transform: 'translateX(-250%) rotate(0deg)'
                  top: 0, left: '100%'

            # Vertical, to bottom left
            when 1
              possibleBgItemPos = ['bottom right', 'top right']

              stationaryBug.css
                transform: 'translate(-100%, -100%) rotate(90deg)'
                top: '100%', left: 0

              unless away
                movingBug.css
                  transform: 'rotate(-90deg)'
                  top: 0, left: 0
              else
                movingBug.css
                  transform: 'translateY(-250%) rotate(90deg)'
                  top: '100%', left: 0

            # Diagonal, to bottom right
            else
              possibleBgItemPos = ['bottom left', 'top right']

              stationaryBug.css
                transform: 'translate(-200%, -100%) rotate(45deg)'
                top: '100%', left: '100%'

              unless away
                movingBug.css
                  transform: 'rotate(-135deg)'
                  top: 0, left: 0
              else
                movingBug.css
                  transform: 'translate(-250%, -250%) rotate(45deg)'
                  top: '100%', left: '100%'

        when 1 # Top right
          switch [0...3].random()
            # Horizontal, to top left
            when 0
              possibleBgItemPos = ['bottom right', 'bottom left']

              stationaryBug.css
                transform: 'translateX(-100%) rotate(180deg)'
                top: 0, left: 0

              unless away
                movingBug.css
                  transform: 'translateX(-100%) rotate(0deg)'
                  top: 0, left: '100%'
              else
                movingBug.css
                  transform: 'translateX(150%) rotate(180deg)'
                  top: 0, left: 0
            # Vertical, to bottom right
            when 1
              possibleBgItemPos = ['bottom left', 'top left']

              stationaryBug.css
                transform: 'translate(-200%, -100%) rotate(90deg)'
                top: '100%', left: '100%'

              unless away
                movingBug.css
                  transform: 'translateX(-100%) rotate(-90deg)'
                  top: 0, left: '100%'
              else
                movingBug.css
                  transform: 'translate(-100%, -250%) rotate(90deg)'
                  top: '100%', left: '100%'

            # Diagonal, to bottom left
            else
              possibleBgItemPos = ['bottom right', 'top left']

              stationaryBug.css
                transform: 'translate(-100%, -100%) rotate(135deg)'
                top: '100%', left: 0

              unless away
                movingBug.css
                  transform: 'translateX(-100%) rotate(-45deg)'
                  top: 0, left: '100%'
              else
                movingBug.css
                  transform: 'translate(100%, -250%) rotate(135deg)'
                  top: '100%', left: 0

        when 2 # Bottom left
          switch [0...3].random()
            # Horizontal, to bottom right
            when 0
              possibleBgItemPos = ['top right', 'top left']

              stationaryBug.css
                transform: 'translate(-200%, -100%) rotate(0deg)'
                top: '100%', left: '100%'

              unless away
                movingBug.css
                  transform: 'translateY(-100%) rotate(180deg)'
                  top: '100%', left: 0
              else
                movingBug.css
                  transform: 'translate(-250%, -100%) rotate(0deg)'
                  top: '100%', left: '100%'

            # Vertical, to top left
            when 1
              possibleBgItemPos = ['top right', 'bottom right']

              stationaryBug.css
                transform: 'translateX(-100%) rotate(-90deg)'
                top: 0, left: 0

              unless away
                movingBug.css
                  transform: 'translateY(-100%) rotate(90deg)'
                  top: '100%', left: 0
              else
                movingBug.css
                  transform: 'translateY(150%) rotate(-90deg)'
                  top: 0, left: 0

            # Diagonal, to top right
            else
              possibleBgItemPos = ['bottom right', 'top left']

              stationaryBug.css
                transform: 'translateX(-200%) rotate(-45deg)'
                top: 0, left: '100%'

              unless away
                movingBug.css
                  transform: 'translateY(-100%) rotate(135deg)'
                  top: '100%', left: 0
              else
                movingBug.css
                  transform: 'translate(-200%, 150%) rotate(-45deg)'
                  top: 0, left: '100%'

        else # Bottom right
          switch [0...3].random()
            # Horizontal, to bottom left
            when 0
              possibleBgItemPos = ['top right', 'top left']

              stationaryBug.css
                transform: 'translate(-100%, -100%) rotate(180deg)'
                top: '100%', left: 0

              unless away
                movingBug.css
                  transform: 'translate(-100%, -100%) rotate(0deg)'
                  top: '100%', left: '100%'
              else
                movingBug.css
                  transform: 'translate(150%, -100%) rotate(180deg)'
                  top: '100%', left: 0

            # Vertical, to top right
            when 1
              possibleBgItemPos = ['bottom left', 'top left']

              stationaryBug.css
                transform: 'translateX(-200%) rotate(-90deg)'
                top: 0, left: '100%'

              unless away
                movingBug.css
                  transform: 'translate(-100%, -100%) rotate(90deg)'
                  top: '100%', left: '100%'
              else
                movingBug.css
                  transform: 'translate(-100%, 150%) rotate(-90deg)'
                  top: 0, left: '100%'

            # Diagonal, to top left
            else
              possibleBgItemPos = ['top right', 'bottom left']

              stationaryBug.css
                transform: 'translateX(-100%) rotate(-135deg)'
                top: 0, left: 0

              unless away
                movingBug.css
                  transform: 'translate(-100%, -100%) rotate(45deg)'
                  top: '100%', left: '100%'
              else
                movingBug.css
                  transform: 'translate(100%, 100%) rotate(-135deg)'
                  top: 0, left: 0

      bgItem.css bgItemPositions[possibleBgItemPos[[0..1].random()]]

    normalizeVector: (vect, multFactor = 1) ->
      magnitude = Math.sqrt(vect.top * vect.top + vect.left * vect.left)
      return { top: vect.top / magnitude * multFactor, left: vect.left / magnitude * multFactor }

    intersects: (el1, el2) ->
      rect1 = $(el1)[0].getBoundingClientRect()
      rect2 = $(el2)[0].getBoundingClientRect()

      !(rect1.top > rect2.bottom || rect1.right < rect2.left ||
        rect1.bottom < rect2.top || rect1.left > rect2.right)

    isOffScreen: (el) ->
      rect = $(el)[0].getBoundingClientRect()

      (rect.left < window.innerWidth * 0.02 or
      rect.top < window.innerHeight * 0.02 or
      rect.right > window.innerWidth * 0.98 or
      rect.bottom > window.innerHeight * 0.89)

    moveBug: (movingBug, stationaryBug, away = false) ->
      movingBugPos = movingBug.offset()
      stationaryBugPos = stationaryBug.offset()

      movementVector = @normalizeVector({
        top: (stationaryBugPos.top - movingBugPos.top) * (unless away then 1 else -1)
        left: (stationaryBugPos.left - movingBugPos.left) * (unless away then 1 else -1)
      }, 1.5)

      delta = 0.02
      if 1-delta < movementVector.top < 1 then movementVector.top = 1
      if -1 < movementVector.top < -(1-delta) then movementVector.top = -1
      if 0 < movementVector.top < delta or -delta < movementVector.top < 0
        movementVector.top = 0

      if 1-delta < movementVector.left < 1 then movementVector.left = 1
      if -1 < movementVector.left < -(1-delta) then movementVector.left = -1
      if 0 < movementVector.left < delta or -delta < movementVector.left < 0
        movementVector.left = 0

      movingBug.offset
        top: (movingBugPos.top + movementVector.top)
        left: (movingBugPos.left + movementVector.left)

  Bug

Constants =
  FPS: 120
  ANSWER_TIMEOUT: 1500

MainController = ($scope, $interval, $timeout, Constants, BugService) ->
  @correctAnswerCount = 0
  @wrongAnswerCount = 0

  @questionOptions = [
    "Species 1",
    "Species 2",
    "Species 3",
    "Species 4"
  ]

  @isMovementFinished = false

  startMovement = =>
    @movement = $interval =>
      b1 = @movingBug.find('.Body')
      b2 = @stationaryBug.find('.Body')

      if BugService.intersects(b1, b2) or BugService.isOffScreen(@movingBug)
        stopMovement()

      $timeout =>
        BugService.moveBug @movingBug, @stationaryBug, @isBugMovingAway
    , 1.0 / Constants.FPS * 1000

    @movement.catch (err) -> return

  stopMovement = =>
    $interval.cancel(@movement)
    @movingBug.find('[id^=Leg] *').css('animation-play-state', 'paused')
    @isMovementFinished = true

  init = =>
    @isMovementFinished = false
    @isBugMovingAway = Math.random() < 0.5

    @movingBug = $('#moving-bug')
    @stationaryBug = $('#stationary-bug')
    @bgItem = $('#background-item')
    # Delete pre-existing bugs inside of the wrapper
    @movingBug.empty()
    @stationaryBug.empty()
    @bgItem.empty()
    # Get bugs and add them to DOM
    @currentEls = BugService.getNextElements()
    @movingBug.append @currentEls.movingBug
    @stationaryBug.append @currentEls.stationaryBug
    @bgItem.append @currentEls.bgItem

    $timeout =>
      BugService.setInitialPositions(@movingBug, @stationaryBug, @bgItem, @isBugMovingAway)
      startMovement()

  @onAnswerSelected = ($index) =>
    $('body').css 'pointer-events', 'none'
    setTimeout ->
      $('body').css 'pointer-events', 'all'
    , Constants.ANSWER_TIMEOUT

    if @currentEls.bugNumber is $index
      swal
        title: "Correct!"
        type: "success"
        timer: Constants.ANSWER_TIMEOUT
        showConfirmButton: false

      @correctAnswerCount++
      $timeout (-> init()), Constants.ANSWER_TIMEOUT
    else
      swal
        title: "Wrong Answer!"
        type: "error"
        timer: Constants.ANSWER_TIMEOUT
        showConfirmButton: false

      @wrongAnswerCount++
      $timeout (-> init()), Constants.ANSWER_TIMEOUT

  init()

  @

angular
  .module('app', [])
  .directive('muserref', MuserrefDirective)
  .directive('marvin', MarvinDirective)
  .directive('muhittin', MuhittinDirective)
  .directive('sukufe', SukufeDirective)
  .directive('nurdane', NurdaneDirective)
  .directive('hayriye', HayriyeDirective)
  .directive('ayse', AyseDirective)
  .directive('dijkstra', DijkstraDirective)
  .directive('stone', StoneDirective)
  .directive('swamp', SwampDirective)
  .constant('Constants', Constants)
  .service('BugService', [
    '$compile', '$rootScope', 'Constants',
    BugService
  ])
  .controller('MainController', [
    '$scope', '$interval', '$timeout', 'Constants', 'BugService',
    MainController
  ])
