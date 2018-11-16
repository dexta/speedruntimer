<timer>
<div class="row">
  <div class="col-3 {opts.bgc}">
    <blockquote class="blockquote text-center">
      {opts.name}
    </blockquote>
  </div>
  <div class={ 'bg-danger':timeisred, 'bg-success':!timeisred, 'col-2':true, 'bg-transparent':editMode}>
    <blockquote hide={editMode} class="blockquote text-center">
      {formatTime(time)}
    </blockquote>
    <blockquote show={editMode} class="blockquote text-center">
      <button class="btn btn-sm btn-primary" onclick={moveUp}>
        <i class="fa fa-arrow-up"></i>
      </button>
      <button class="btn btn-sm btn-primary" onclick={moveDown}>
        <i class="fa fa-arrow-down"></i>
      </button>
    </blockquote>
  </div>
  <div class="col-2">
    <blockquote class="blockquote text-center">{formatTime(bestTime)}</blockquote>
  </div>
  <div class="col-5">
    <button onclick={start} class="btn btn-success">Start</button>
    <button onclick={pause} class="btn btn-info">Pause</button>
    <button hide={beatthescore||givemestats} onclick={stop} class="btn btn-danger">Stop</button>
    <button show={givemestats} onclick={savestat} class="btn btn-info">SaveStat</button>
    <button show={beatthescore} onclick={save} class="btn btn-danger">Save</button>

    <button onclick={toggleStats} class="pull-right btn btn-primary">
      <i class="fa fa-line-chart"></i>
    </button>
  </div>
</div>
<chartjs if={showChart} cIndex="{timerID}" cTitle="{opts.name}"></chartjs>
<hr>
<script>
let that = this;

this.timerID = this.opts.namedid;
// this.bestTime = this.opts.besttime;
this.editMode = (this.opts.editmode||this.opts.editmode==="true"||false);
this.time = 0;
this.freq = 50; // time in msec to update
this.running = false;
this.timeisred = false;
this.beatthescore = false;
this.givemestats = false;
this.showChart = false;

this.lastTime = 0;
this.startTime = 0;

this.start = () => {
  that.time = 0;
  that.lastTime = 0;
  that.startTime = Date.now();
  that.running = true;
  that.beatthescore = false;
  that.givemestats = false;
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
  if(!that.beatthescore) {
    that.givemestats = true;
  }
  console.log(`Stop ${that.opts.name} at ${that.formatTime(that.time)}`);
};

this.save = () => {
  console.log("we do the save dance !");
  riotux.action('timerList', 'updateTimer', that.timerID, {best:that.time});
  riotux.action('timerList', 'saveAll');
  that.savestat();
};

this.savestat = () => {
  console.log("save the stat "+that.formatTime(that.time));
  riotux.action('listOfTimes', 'updateTime', that.timerID, that.time);
};

this.redo = () => {
  if(!that.running) return;
  let timeNow = Date.now();
  that.time = (timeNow-that.startTime)+that.lastTime;
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

this.moveUp = () => {
  let canI = riotux.action('timerList', 'moveItemUp', that.timerID);
  console.log(`move up return ${canI}`);
};

this.moveDown = () => {
  let canI = riotux.action('timerList', 'moveItemDown', that.timerID);
  console.log(`move down return ${canI}`);
};

this.toggleStats = () => {
  that.showChart = (that.showChart||that.showChart==='true'||false)? false : true;
};

this.on("update", () => {
  if(that.time>that.bestTime) {
    that.timeisred = true;
  } else {
    that.timeisred = false;
  }
  that.editMode = (that.opts.editmode||that.opts.editmode==="true"||false);
});

this.on("mount", () => {
  riotux.action('timeslist','loadLevelDetails', that.timerID);
});

riotux.subscribe(that, 'timeslist', ( state, state_value ) => {
  console.dir(state_value);
});

</script>

</timer>