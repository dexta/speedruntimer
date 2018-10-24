<timer>
<div class="row">
  <div class="col-3">{opts.name}</div>
  <div class="col-2">
    <span>{formatTime(time)}</span>
  </div>
  <div class="col-2">
    <span class={ bg-danger: timeisred, bg:green}>{formatTime(bestTime)}</span>
  </div>
  <div class="col-5">
    <button onclick={start} class="btn btn-success">Start</button>
    <button onclick={pause} class="btn btn-info">Pause</button>
    <button onclick={stop} class="btn btn-danger">Stop</button>
  </div>
</div>
<hr>
<script>
let that = this;

this.timerID = this.opts.namedid;
this.bestTime = this.opts.besttime;
this.time = 0;
this.freq = 50; // time in msec to update
this.running = false;
this.timeisred = true;

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
    // that.time = 0;
  } else {
    that.running = true;
    that.startTime = Date.now();
    // that.time = 0;
    that.redo();
  }
};

this.stop = () => {
  if(!that.running) return;
  that.pause();
  console.log(`Stop ${that.opts.name} at ${that.formatTime(that.time)}`);
};

this.redo = () => {
  if(!that.running) return;
  let timeNow = Date.now();
  that.time = (timeNow-that.startTime)+that.lastTime;
  // that.formatTime();
  that.update();
  setTimeout(that.redo, that.freq);
};

this.formatTime = (toHumanTime) => {
  let tis = Math.floor(toHumanTime/1000);
  let mil = that.time%tis||0;
  // console.log("milsec "+mil);
  let sec = ("0"+Math.floor(tis%3600%60||0)).slice(-2);
  let min = ("0"+Math.floor(tis%3600/60||0)).slice(-2);
  let std = ("0"+Math.floor(tis/3600||0)).slice(-2);

  // that.timeForHuman = `${std}:${min}:${sec}:${mil}`;
  // that.update();
  return `${std}:${min}:${sec}:${mil}`;
};

this.on("update", () => {
  if(that.time>that.bestTime) {
    that.timeisred = true;
  } else {
    that.timeisred = false;
  }
});



</script>

</timer>