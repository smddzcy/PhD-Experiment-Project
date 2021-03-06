MuserrefDirective = ->
  restrict: 'E'
  replace: true
  templateUrl: (el, attrs) ->
    switch parseInt attrs.type
      when 1 then 'img/muserref-2.svg'
      when 2 then 'img/muserref-3.svg'
      when 3 then 'img/muserref-4.svg'
      else 'img/muserref.svg'

  link: (element, attributes, scope) ->
    $(attributes[0]).addClass 'responsive-img'

MarvinDirective = ->
  restrict: 'E'
  replace: true
  templateUrl: (el, attrs) ->
    switch parseInt attrs.type
      when 1 then 'img/marvin-2.svg'
      when 2 then 'img/marvin-3.svg'
      when 3 then 'img/marvin-4.svg'
      else 'img/marvin.svg'

  link: (element, attributes, scope) ->
    $(attributes[0]).addClass 'responsive-img'

MuhittinDirective = ->
  restrict: 'E'
  replace: true
  templateUrl: (el, attrs) ->
    switch parseInt attrs.type
      when 1 then 'img/muhittin-2.svg'
      when 2 then 'img/muhittin-3.svg'
      when 3 then 'img/muhittin-4.svg'
      else 'img/muhittin.svg'

  link: (element, attributes, scope) ->
    $(attributes[0]).addClass 'responsive-img'

SukufeDirective = ->
  restrict: 'E'
  replace: true
  templateUrl: (el, attrs) ->
    switch parseInt attrs.type
      when 1 then 'img/sukufe-2.svg'
      when 2 then 'img/sukufe-3.svg'
      when 3 then 'img/sukufe-4.svg'
      else 'img/sukufe.svg'

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
    '<sukufe type="0" bug-number="0"></sukufe>',
    '<muhittin type="0" bug-number="1"></muhittin>',
    '<marvin type="0" bug-number="2"></marvin>',
    '<muserref type="0" bug-number="3"></muserref>',

    '<sukufe type="1" bug-number="0"></sukufe>',
    '<muhittin type="1" bug-number="1"></muhittin>',
    '<marvin type="1" bug-number="2"></marvin>',
    '<muserref type="1" bug-number="3"></muserref>',

    '<sukufe type="2" bug-number="0"></sukufe>',
    '<muhittin type="2" bug-number="1"></muhittin>',
    '<marvin type="2" bug-number="2"></marvin>',
    '<muserref type="2" bug-number="3"></muserref>',

    '<sukufe type="3" bug-number="0"></sukufe>',
    '<muhittin type="3" bug-number="1"></muhittin>',
    '<marvin type="3" bug-number="2"></marvin>',
    '<muserref type="3" bug-number="3"></muserref>'
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

  indirectMotionCount = 0
  indirectMotionFreq = 140

  Bug =
    getNextElements: ->
      # Shuffle the bugs on each block (each 16 trials)
      if bugNumber % 16 is 0
        MOVING_BUGS.shuffle()
        STATIONARY_BUGS.shuffle()

      # Get link functions
      linkFnMoving = $compile MOVING_BUGS[bugNumber % MOVING_BUGS.length]
      linkFnStationary = $compile STATIONARY_BUGS[bugNumber % STATIONARY_BUGS.length]

      # Compile the elements by giving them a scope
      movingBugDomEl = linkFnMoving $rootScope.$new()
      stationaryBugDomEl = linkFnStationary $rootScope.$new()
      bgItemDomEl = $compile(BG_ITEMS.random())($rootScope.$new())

      bugNumber += 1

      return {
        movingBug: movingBugDomEl
        stationaryBug: stationaryBugDomEl
        bgItem: bgItemDomEl
        bugNumber: parseInt movingBugDomEl.attr('bug-number')
      }

    getTrialNumber: ->
      bugNumber

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

              canBeIndirect = true

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

              canBeIndirect = true

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

              canBeIndirect = true

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

              canBeIndirect = true

      bgItem.css bgItemPositions[possibleBgItemPos[[0..1].random()]]
      # if canBeIndirect then Math.random() > 0.60 else false
      if canBeIndirect then true

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

      delta = 0.004
      (rect.left < window.innerWidth * delta or
      rect.top < window.innerHeight * delta or
      rect.right > window.innerWidth * (1 - delta) or
      rect.bottom > window.innerHeight * 0.9 + delta)

    rotateVector: (vector, degree) ->
      cos_t = Math.cos degree / 180 * Math.PI
      sin_t = Math.sin degree / 180 * Math.PI

      return {
        left: cos_t * vector.left - cos_t * vector.top,
        top: sin_t * (vector.left + vector.top)
      }

    getMovementVector: (movingBug, stationaryBug, away = false) ->
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

      movementVector

    sumVectors: (v1, v2) ->
      return {
        top: (v1.top + v2.top)
        left: (v1.left + v2.left)
      }

    moveBug: (movingBug, stationaryBug, away = false) ->
      movementVector = @getMovementVector(movingBug, stationaryBug, away)

      movingBugPos = movingBug.offset()
      movingBug.offset (@sumVectors movingBugPos, movementVector)

    straightenVector: (vector) ->
      for k, v of vector
        if (v < 0 && v > -1) || (v > 0 && v < 1)
          vector[k] = 0
        else if v < -1
          vector[k] = -1
        else if v > 1
          vector[k] = 1
      vector

    getIndirectMovementVector: (movingBug, stationaryBug, away = false) ->
      movementVector = @getMovementVector movingBug, stationaryBug, away
      indirectMotionCount = (indirectMotionCount + 1) % indirectMotionFreq

      x = Math.sqrt(2) / 2
      if indirectMotionCount <= indirectMotionFreq / 2
        @turnBug movingBug, -45
        movementVector = {
          top: movementVector.top * x - movementVector.left * x
          left: (movementVector.top + movementVector.left) * x
        }
        movementVector = @straightenVector(movementVector) if away
      else
        @turnBug movingBug, 45
        movementVector = {
          top: (movementVector.top + movementVector.left) * x
          left: -movementVector.top * x +  movementVector.left * x
        }
        movementVector = @straightenVector(movementVector) if away

      movementVector

    turnBug: (bug, deg) ->
      style = $(bug).get(0).style
      getRotation = () ->
        rot = style["transform"].match(/rotate\((.*)\)/)[1]
        rot = parseInt(rot.substr(0, rot.length - 3))

      # Calculate the base degree once
      @baseDeg = getRotation() unless @baseDeg?
      newDeg = @baseDeg + parseInt(deg)
      currentDeg = getRotation()

      # Don't make redundant style changes
      unless currentDeg is newDeg
        style["transform"] = style["transform"].replace(/rotate\(.*\)/, "rotate(#{newDeg}deg)")

    moveBugIndirect: (movingBug, stationaryBug, away = false) ->
      @staticStationaryBug ?= stationaryBug
      movementVector = @getIndirectMovementVector(movingBug, @staticStationaryBug, away)
      movingBugPos = movingBug.offset()
      movingBug.offset (@sumVectors movingBugPos, movementVector)

  Bug

Constants =
  FPS: 140
  ANSWER_TIMEOUT: 1500

MainController = ($scope, $interval, $timeout, Constants, BugService) ->
  # Initialize the local storage store, if it's not initialized before
  unless localStorage._expData?
    localStorage._expData = JSON.stringify {}

  @correctAnswerCount = 0
  @wrongAnswerCount = 0

  @questionOptions = [
    "Species 1",
    "Species 2",
    "Species 3",
    "Species 4"
  ]

  @isMovementFinished = false
  @firstInit = true

  @startMovement = (isMovementIndirect) =>
    b1 = @movingBug.find('.Body')
    b2 = @stationaryBug.find('.Body')

    if isMovementIndirect
      @movement = $interval =>
        if BugService.intersects(b1, b2) or (@isBugMovingAway and BugService.isOffScreen(@movingBug))
          @stopMovement()

        $timeout =>
          BugService.moveBugIndirect @movingBug, @stationaryBug, @isBugMovingAway
      , 1.0 / Constants.FPS * 1000
    else
      @movement = $interval =>
        if BugService.intersects(b1, b2) or (@isBugMovingAway and BugService.isOffScreen(@movingBug))
          @stopMovement()

        $timeout =>
          BugService.moveBug @movingBug, @stationaryBug, @isBugMovingAway
      , 1.0 / Constants.FPS * 1000

    @movement.catch angular.noop

  @stopMovement = =>
    $interval.cancel(@movement)
    @movingBug.find('[id*=Leg] *').css('animation-play-state', 'paused')
    @isMovementFinished = true

  @init = () =>
    # Currenly, only 1 block.
    if BugService.getTrialNumber() is 32
      $('#main-wrapper').hide()
      return

    @pathBasedAnswer = $('body').attr('path-based')?
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
      @isIndirect = BugService.setInitialPositions(@movingBug, @stationaryBug, @bgItem, @isBugMovingAway)
      @startMovement @isIndirect

  @log = (key, val) =>
    data = JSON.parse localStorage._expData
    data[key].push val
    localStorage._expData = JSON.stringify data

  @isAnswerCorrect = ($index) =>
    if @pathBasedAnswer
      # 0 => Directly Forward, 1 => Directly Away, 2 => Indirectly Forward, 3 => Indirectly Away
      ((@isIndirect << 1) | @isBugMovingAway) is $index
    else
      @currentEls.bugNumber is $index

  @onAnswerSelected = ($index) =>
    $('body').css 'pointer-events', 'none'
    $timeout ->
      $('body').css 'pointer-events', 'all'
    , Constants.ANSWER_TIMEOUT

    # Initialize the local storage store if it's the first answer
    if @firstInit
      @localStorageKey = (Date.now() / 1000) | 0
      data = JSON.parse localStorage._expData
      data[@localStorageKey] = []
      localStorage._expData = JSON.stringify data

      @firstInit = false

    if @isAnswerCorrect $index
      @log @localStorageKey, {
        time: (Date.now() / 1000) | 0
        correct: true
        selectedAnswer: @questionOptions[$index]
        correctAnswer: @questionOptions[@currentEls.bugNumber]
        pathBased: @pathBasedAnswer
      }

      swal
        title: ""
        type: "success"
        timer: Constants.ANSWER_TIMEOUT
        showConfirmButton: false

      @correctAnswerCount++
      $timeout (=> @init()), Constants.ANSWER_TIMEOUT
    else
      @log @localStorageKey, {
        time: (Date.now() / 1000) | 0
        correct: false
        selectedAnswer: @questionOptions[$index]
        correctAnswer: @questionOptions[@currentEls.bugNumber]
        pathBased: @pathBasedAnswer
      }

      swal
        title: ""
        type: "error"
        timer: Constants.ANSWER_TIMEOUT
        showConfirmButton: false

      @wrongAnswerCount++
      $timeout (=> @init()), Constants.ANSWER_TIMEOUT

  @init()

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
