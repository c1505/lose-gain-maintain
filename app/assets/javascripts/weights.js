$(".weights.index").ready(function() {
  var promise = getWeights();
  promise.done(function (data) {
    var pounds = data.map(function(x) {
      return x.pounds
    })
    var date = data.map(function(x) {
      return x.date.split("T")[0]
    })
    drawChart(pounds, date);
  })
});

function drawChart(pounds, date) {
  var ctx = document.getElementById("myChart").getContext('2d');
  var myChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: date.reverse(),
        datasets: [{
            label: 'Pounds',
            data: pounds.reverse(),
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
            ],
            borderColor: [
                'rgba(255,99,132,1)',
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:false
                }
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