<timer>
<div class="row">
  <div class="col-3">{opts.name}</div>
  <div class="col-3">{timeForHuman}</div>
  <div class="col-6">
    <button onclick={start} class="btn btn-success">Start</button>
    <button onclick={pause} class="btn btn-info">Pause</button>
    <button onclick={stop} class="btn btn-danger">Stop</button>
  </div>
</div>

<script>
let that = this;

this.time = 0;
this.intervalID = 0;
this.lastTime = 0;
this.startTime = 0;
this.timeForHuman = 0;

this.start = () => {
  that.startTime = new Date()/1;
  that.intervalID = setInterval(that.redo,223);
};

this.pause = () => {
  if(that.intervalID===0) return that.start();
  that.stop();
  that.intervalID=0;  
  that.redo();  
  this.lastTime += that.time;
};

this.stop = () => {
  clearInterval(that.intervalID);
};

this.redo = () => {
  let timeNow = new Date()/1;
  that.time = (timeNow-that.startTime)+that.lastTime;
  that.formatTime();
};

this.formatTime = () => {
  let tis = Math.floor(that.time/1000);
  let mil = that.time%tis||0;
  // console.log("milsec "+mil);
  let sec = ("0"+Math.floor(tis%3600%60)).slice(-2);
  let min = ("0"+Math.floor(tis%3600/60)).slice(-2);
  let std = ("0"+Math.floor(tis/3600)).slice(-2);

  that.timeForHuman = `${std}:${min}:${sec}:${mil}`;
  that.update();
};

</script>

</timer>