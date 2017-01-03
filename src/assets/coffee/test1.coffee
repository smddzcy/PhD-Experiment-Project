class Worker
  constructor: (name) ->
    @name = name

  sayName: ->
    console.log "Hey, I'm: '#{@name}'"

class Manager extends Worker
  sayName: ->
    console.log "Wow I can manage people, also I'm: '#{@name}'"

worker1 = new Worker "worker1"
manager1 = new Manager "manager1"
worker1.sayName()
manager1.sayName()
