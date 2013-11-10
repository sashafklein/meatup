$ ->

  now = $("#timer").data 'now'
  start = $("#timer").data 'start'
  redirect = $("#timer").data 'redirect'
  path = $('#timer').data 'path'
  left = 300 - (now - start)

  seconds = left % 60
  minutes = (left - (seconds)) / 60
  clock = self.setInterval(->
    timer()
  , 1000)

  timer = -> 
    seconds = seconds - 1
    if seconds < 0
      seconds = 59
      minutes = minutes - 1
      if minutes < 0
        clearInterval clock 
        $("#timer").html "TIME OUT"
        $.post path , ->
          window.location.href = redirect
          return
      
    if seconds < 10
      $("#timer").html "#{minutes} : 0 #{seconds} <br> LEFT TO PAY"
    else
      $("#timer").html "#{minutes} : #{seconds} <br> LEFT TO PAY"