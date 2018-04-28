$(".competitions.show").ready(function() {
  var id = $("#competitions").data('url')
  var promise = getPercents(id);
  promise.done(function(incoming) {
    var incoming = incoming
    var data = incoming.map(function (nested) {
      return nested.map(function (element) {
        return { x: element.date, y: element.percentage }
      })
    })
    data = [ [ incoming[0][0].user, data[0] ], [incoming[1][0].user, data[1] ]]
    drawPercentsChart(data);
  })
});

function drawPercentsChart(data) {
  var ctx = document.getElementById("percentage").getContext('2d');
  var chart = new Chart(ctx, {
    type: 'line',
    data: {
      datasets: [{
          label: data[0][0],
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgba(255,99,132,1)',
          borderWidth: 1,
          fill: false,
          data: data[0][1]
        },
        {
          label: data[1][0],
          backgroundColor: 'rgba(55,55,189,1)',
          borderColor: 'rgba(55,55,189,1)',
          borderWidth: 1,
          fill: false,
          data: data[1][1]
        }
      ]
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
  // var myChart = new Chart(ctx, {
  //   type: 'line',

  //   data: {
  //       labels: dates,
  //       datasets: [{
  //           label: Object.keys(data.datasets[0])[0],
  //           data: vals1[0],
  //           fill: false,
  //           spanGaps: true,
  //           backgroundColor: 'rgba(240,50,50,1)',
  //           borderColor: 'rgba(240,50,50,1)',
  //           borderWidth: 1
  //       }, {
  //         label: Object.keys(data.datasets[1])[0],
  //         data: vals2[0],
  //         fill: false,
  //         spanGaps: true,
  //         backgroundColor: 'rgba(55,55,189,1)',
  //         borderColor: 'rgba(55,55,189,1)',
  //         borderWidth: 1
  //     }]
  //   },
  //   options: {
  //       title: {
  //         display: true,
  //         text: 'Percent Change',
  //       },
  //       scales: {
  //           yAxes: [{
  //               ticks: {
  //                   beginAtZero:false
  //               }
  //           }]
  //       }
  //   }
  // });
}

function getPercents(id) {
  return $.ajax({
    url: id + ".json"
  });
}
