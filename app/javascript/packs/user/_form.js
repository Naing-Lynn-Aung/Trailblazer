$('#profile').on('change', function(e) {
  var reader = new FileReader();
  reader.onload = function (event) {
      $('#img_prev')
          .attr('src', event.target.result)
          .width('30%');
  };
  reader.readAsDataURL(e.target.files[0]);
});

