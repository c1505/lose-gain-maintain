$(".competitions.show").ready(function() {
  var id = $("#competitions").data('url')
  var promise = getPercents(id);
  promise.done(function (data) {
    var dates = data.dates.map(function(x) {
      return x.split("T")[0]
    })
    drawPercentsChart(data, dates);
  })
});

function drawPercentsChart(data,dates) {
  var ctx = document.getElementById("percentage").getContext('2d');
  var myChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: dates,
        datasets: [{
            label: Object.keys(data.datasets[0])[0],
            data: Object.values(data.datasets[0])[0],
            fill: false,
            spanGaps: true,
            backgroundColor: [
                'rgba(240,50,50,1)',
            ],
            borderColor: [
                'rgba(240,50,50,1)',
            ],
            borderWidth: 1
        }, {
          label: Object.keys(data.datasets[1])[0],
          data: Object.values(data.datasets[1])[0],
          fill: false,
          spanGaps: true,
          backgroundColor: [
              'rgba(55,55,189,1)',
          ],
          borderColor: [
              'rgba(55,55,189,1)',
          ],
          borderWidth: 1
      }]
    },
    options: {
        title: {
          display: true,
          text: 'Percent Change',
        },
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
  
function getPercents(id) {
  return $.ajax({
      url: id + ".json"
  });
}