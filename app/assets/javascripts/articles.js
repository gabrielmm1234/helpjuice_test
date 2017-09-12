function build_chart(data) {
  Highcharts.chart('container', {
    chart: {
      plotBackgroundColor: null,
      plotBorderWidth: null,
      type: 'pie'
    },
    title: {
      text: 'Search times for articles'
    },
    tooltip: {
      pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
    },
    plotOptions: {
      pie: {
          allowPointSelect: true,
          cursor: 'pointer',
          dataLabels: {
              enabled: false
          },
          showInLegend: true
      }
    },
    series: [{
      name: 'search',
      colorByPoint: true,
      data: data
    }]
  });
}

$(document).ready(function () {
  $.ajax({
    method: 'GET',
    url: '/article/info',
    dataType: 'json',
    success: function(response) {
      build_chart(response);
    }
  });
});
