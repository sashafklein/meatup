jQuery ->
	if $('#weight_chart').length
	  Morris.Donut
	    element: 'weight_chart'
	    data: [
	      {label: "Pounds Sold", value: $('#weight_chart').data('sold')}
	      {label: "Pounds Left", value: $('#weight_chart').data('left')}
	    ]
	    colors: ['#0066CC', "#880000"]

	if $('#sales_chart').length
	  Morris.Donut
	    element: 'sales_chart'
	    data: [
	      {label: "Revenue Made", value: $('#sales_chart').data('sold')}
	      {label: "Est. Revenue Left", value: $('#sales_chart').data('left')}
	    ]
	    colors: ["#336633", "#880000"]
	if $('#status_chart').length
	  Morris.Donut
	    element: 'status_chart'
	    data: [
	      {label: "Incomplete", value: $('#status_chart').data('zero')}
	      {label: "Downpaid", value: $('#status_chart').data('one')}
	      {label: "Fully Paid", value: $('#status_chart').data('two')}
	      {label: "Received", value: $('#status_chart').data('three')}
	    ]
	    colors: ["#880000", '#E09050', '#989898', '#000000']