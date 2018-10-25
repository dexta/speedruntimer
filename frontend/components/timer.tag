<timer>
<div class="row  {opts.bgc}">
  <div class="col-3">
    <span show={editMode}>
      <i class="fa fa-arrow-up"></i>
      <i class="fa fa-arrow-down"></i>
    </span>
    {opts.name}
  </div>
  <div class={  'bg-danger':timeisred, 'bg-success':!timeisred, 'col-2':true }>
    <span>{formatTime(time)}</span>
  </div>
  <div class="col-2">
    <span>{formatTime(bestTime)}</span>
  </div>
  <div class="col-5">
    <button onclick={start} class="btn btn-success">Start</button>
    <button onclick={pause} class="btn btn-info">Pause</button>
    <button hide={beatthescore} onclick={stop} class="btn btn-danger">Stop</button>
    <button show={beatthescore} onclick={save} class="btn btn-danger">Save</button>
  </div>
</div>
<hr>
<script>
let that = this;

this.timerID = this.opts.namedid;
this.bestTime = this.opts.besttime;
this.editMode = (this.opts.editmode||this.opts.editmode==="true"||false);
this.time = 0;
this.freq = 50; // time in msec to update
this.running = false;
this.timeisred = false;
this.beatthescore = false;

this.lastTime = 0;
this.startTime = 0;

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
  } else {
    that.running = true;
    that.startTime = Date.now();
    that.redo();
  }
};

this.stop = () => {
  if(!that.running) return;
  that.pause();
  that.beatthescore = (that.time<that.bestTime||false);
  console.log(`Stop ${that.opts.name} at ${that.formatTime(that.time)}`);
};

this.save = () => {
  console.log("we do the save dance !");
  riotux.action('timerList', 'updateTimer', that.timerID, {best:that.time});
  riotux.action('timerList', 'saveAll');
}

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
  let mil = toHumanTime%tis||0;

  let sec = ("0"+Math.floor(tis%3600%60||0)).slice(-2);
  let min = ("0"+Math.floor(tis%3600/60||0)).slice(-2);
  let std = ("0"+Math.floor(tis/3600||0)).slice(-2);

  return `${std}:${min}:${sec}:${mil}`;
};

this.on("update", () => {
  if(that.time>that.bestTime) {
    that.timeisred = true;
  } else {
    that.timeisred = false;
  }
  that.editMode = (that.opts.editmode||that.opts.editmode==="true"||false);
});

</script>

</timer>