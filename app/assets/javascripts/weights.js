$(".weights.index").ready(function() {
  var promise = getWeights();
  promise.done(function(data) {
    var pounds = data.weights.map(function(x) {
      return { x: x.date, y: x.pounds }
    })
    drawChart(data, pounds);
  })
});

function drawChart(data, pounds) {
  var ctx = document.getElementById("myChart").getContext('2d');
  debugger;
  var chart = new Chart(ctx, {
    type: 'line',
    data: {
      datasets: [{
        backgroundColor: 'rgba(255, 99, 132, 0.2)',
        borderColor: 'rgba(255,99,132,1)',
        borderWidth: 1,
        data: pounds
      }]
    },
    options: {
      scales: {
        xAxes: [{
          type: 'time',
          distribution: 'series'
        }]
      }
    }
  });

}

function getWeights() {
  return $.ajax({
    url: "weights.json"
  });
}
