import c3 from 'c3';
import 'c3/c3.min.css';

document.addEventListener('DOMContentLoaded', () => {
  var chartData = {
    columns: [
      ['USD', 30, 200, 100, 400, 150, 250],
      ['EUR', 50, 20, 10, 40, 15, 25]
    ]
  };

  c3.generate({
    bindto: '#currency-chart',
    data: {
      columns: chartData.columns,
      type: 'line'
    }
  });
});
