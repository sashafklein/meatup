$ ->

  $('.collapse_trigger').click ->
    target = $(@).data 'target'
    $("\##{target}").collapse 'toggle'
    return false
