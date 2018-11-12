<chartjs>
<canvas height="400px"></canvas>

<script>
let that = this;
this.chartIndex = this.opts.cindex;
this.chartTitle = this.opts.ctitle;

this.chartData = {
  labels: [1541099353543,1541103682925,1541181562021,1541441368948,1541887420053],
  datasets: [{
    label: "My First dataset",
    backgroundColor: 'rgb(255, 64, 64)',
    borderColor: 'rgb(255, 64, 64)',
    data: [574395,638715,681252,651999,402965],
  }]
};

this.chartOptions = {
  maintainAspectRatio: false,
  elements: {
    line: {
      fill: false
    }
  },
  scales: {
    yAxes: [{
      ticks: {
        beginAtZero:true,
        callback: function(label, index, labels) {
          
          return that.formatTime(label);
        }
      }
    }],
    xAxes: [{
      ticks: {
        callback: (label, index, labels) => {
          return that.formatDate(label);
        }
      }
    }]
  }
};

this.getData = (localName) => {
  let rawLocal = JSON.parse( localStorage.getItem(localName) );
  that.chartData.labels = [];
  that.chartData.datasets[0].data = [];
  for(let c in rawLocal) {
    that.chartData.labels.push(c);
    that.chartData.datasets[0].data.push(rawLocal[c]);
  }
  that.chartData.datasets[0].label = that.opts.ctitle;
};


this.on('mount', () => {
  that.getData(that.chartIndex);
  that.drawChart();
});

this.drawChart = () => {
  let ctx = that.root.querySelector('canvas').getContext("2d");
  ctx.height = 200;
  let chart = new Chart(ctx,{
    type: 'line',
    data: that.chartData,
    options: that.chartOptions
  });
};

this.formatDate = (timeinsec) => {
  return moment(parseInt(timeinsec)).format("YYYY:MM:DD HH:mm:ss");
};

this.formatTime = (toHumanTime) => {
  let tis = Math.floor(toHumanTime/1000);
  let mil = toHumanTime%tis||0;

  let sec = ("0"+Math.floor(tis%3600%60||0)).slice(-2);
  let min = ("0"+Math.floor(tis%3600/60||0)).slice(-2);
  let std = ("0"+Math.floor(tis/3600||0)).slice(-2);

  return `${std}:${min}:${sec}:${mil}`;
};

</script>
<style scoped>
    :scope {
      display: inline-block;
      width: 100%;
    }
</style>
</chartjs>