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
<hr>
<script>
let that = this;

this.time = 0;
this.freq = 200; // time in msec to update
this.running = false;


this.lastTime = 0;
this.startTime = 0;
this.timeForHuman = 0;

this.start = () => {
  that.time = 0;
  that.lastTime = 0;
  that.startTime = Date.now();
  that.running = true;
  that.redo();
};

this.pause = () => {
  if(that.running) {
    that.running = false;
    that.lastTime = that.time;
    that.time = 0;
  } else {
    that.running = true;
    that.startTime = Date.now();
    that.time = 0;
    that.redo();
  }
  
  console.dir(that);
};

this.stop = () => {
  if(!that.running) return;
  that.pause();
  console.log(`Stop ${that.opts.name} at ${that.timeForHuman}`);
};

this.redo = () => {
  if(!that.running) return;
  let timeNow = Date.now();
  that.time = (timeNow-that.startTime)+that.lastTime;
  that.formatTime();
  setTimeout(that.redo, that.freq);
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