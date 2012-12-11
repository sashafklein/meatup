jQuery ->
	$('.row .bundle').on "click", (e) ->
		e.preventDefault()
		$collapse = $(@).closest('.collapse-group').find('.collapse')
		$collapse.collapse 'toggle'