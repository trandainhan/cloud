function getPrice (sel, vm_id) {
	$.ajax({
		beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
	  url: '/machines/iso_price',
	  type: 'POST',
	  data: {iso_id: $(sel).val(), vm_id: vm_id},
	  success: function(data) {
		//called when successful
		$('span#price-'+vm_id).html(data);
	  },
	  error: function(e) {
		//called when there is an error
			console.log(e.message);
	  }
	});
}