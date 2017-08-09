$(".competitions.show").ready(function() {
  var id = $("#competitions").data('url')
  var promise = getPercents(id);
  promise.done(function (data) {
    drawPercentsChart(data);
  })
});

function drawPercentsChart(data) {
}
  
function getPercents(id) {
  return $.ajax({
      url: id + ".json"
  });
}