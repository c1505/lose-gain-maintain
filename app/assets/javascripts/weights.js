$(".weights.index").ready(function() {
  var promise = getWeights();
  promise.done(function(data) {
    var pounds = data.weights.map(function(x) {
      return { x: x.date, y: x.pounds }
    })
    drawNoDataPoints(data, pounds);
  })
  $("#month").click(function() {
        var promise = getMonth();
        promise.done(function(data) {
          var pounds = data.weights.map(function(x) {
            return { x: x.date, y: x.pounds }
          })
          drawChart(data, pounds);
        })
  });
    $("#threeMonths").click(function() {
        var promise = getThreeMonths();
        promise.done(function(data) {
          var pounds = data.weights.map(function(x) {
            return { x: x.date, y: x.pounds }
          })
          drawChart(data, pounds);
        })
  });
});

function drawChart(data, pounds) {
  var ctx = document.getElementById("myChart").getContext('2d');
  var chart = new Chart(ctx, {
    type: 'line',
    data: {
      datasets: [{
        label: "Weights",
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

function drawNoDataPoints(data, pounds) {
  var ctx = document.getElementById("myChart").getContext('2d');
  var chart = new Chart(ctx, {
    type: 'line',
    data: {
      datasets: [{
        label: "Weights",
        backgroundColor: 'rgba(255, 99, 132, 0.2)',
        borderColor: 'rgba(255,99,132,1)',
        borderWidth: 1,
        data: pounds,
        pointRadius: 0,
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

function getMonth() {
  return $.ajax({
    url: "weights.json?months=1"
  });
}

function getThreeMonths() {
  return $.ajax({
    url: "weights.json?months=3"
  });
}
