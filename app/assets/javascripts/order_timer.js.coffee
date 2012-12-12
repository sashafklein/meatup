$(document).ready ->

  now = $("#timer").attr('data-now')
  start = $("#timer").attr('data-start')
  url = $("#timer").attr('data-url')
  left = 300 - (now - start)

  if (left < 1)
    clearInterval clock
    $("#timer").html("TIME OUT")
    alert "You ran out of time to pay. Please place your order again."
    location = url

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
        alert "You ran out of time to pay, and your order has been rolled back. Please place your order again."
        window.location.href = url
        return
      
    if seconds < 10
      $("#timer").html "#{minutes} : 0 #{seconds} <br> LEFT TO PAY"
    else
      $("#timer").html "#{minutes} : #{seconds} <br> LEFT TO PAY"