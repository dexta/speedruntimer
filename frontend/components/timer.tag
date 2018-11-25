<timer>
<div class="row">
  <div class="col-3 {timerOBJ.bgcolor}">
    <blockquote class="blockquote text-center">
      {timerOBJ.name}
    </blockquote>
  </div>
  <div class={ 'bg-danger':timeisred, 'bg-success':!timeisred, 'col-2':true, 'bg-transparent':editMode}>
    <blockquote hide={editMode} class="blockquote text-center">
      {formatTimeSpend(time)}
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
    <blockquote class="blockquote text-center">{formatTimeSpend(timerOBJ.best)}</blockquote>
  </div>
  <div class="col-5">
    <button onclick={start} class="btn btn-success">Start</button>
    <button onclick={pause} class="btn btn-info">Pause</button>
    <button hide={beatthescore||givemestats} onclick={stop} class="btn btn-danger">Stop</button>
    <button show={givemestats} onclick={savestat} class="btn btn-info">SaveStat</button>
    <!-- <button show={beatthescore} onclick={save} class="btn btn-danger">Save</button> -->

    <button onclick={toggleStats} class="pull-right btn btn-primary">
      <i class="fa fa-line-chart"></i>
    </button>
    <button onclick={toggleTable} class="pull-right btn btn-warning">
      <i class="fa fa-edit"></i>
    </button>
  </div>
</div>
<statTimeEdit if={showTimeTable} cindex="{timerID}"></statTimeEdit>
<chartjs if={showChart} cIndex="{timerID}" cTitle="{timerOBJ.name}"></chartjs>
<hr>
<script>
let that = this;

this.formatTimeSpend = formatTimeSpend;

this.timerID = this.opts.namedid;
this.timerOBJ = {};

this.editMode = (this.opts.editmode||this.opts.editmode==="true"||false);
this.time = 0;
this.freq = 50; // time in msec to update
this.running = false;
this.timeisred = false;
// this.beatthescore = false;
this.givemestats = false;
this.showChart = false;
this.showTimeTable = false;

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
  that.givemestats = false;
};

this.stop = () => {
  if(!that.running) return;
  that.pause();
  // that.beatthescore = (that.time<that.timerOBJ.best||false);
  // if(!that.beatthescore) {
    that.givemestats = true;
  // }
  console.log(`Stop ${that.opts.name} at ${formatTimeSpend(that.time)}`);
};

// this.save = () => {
  // console.log("we do the save dance !");
  // riotux.action('timerList', 'updateTimer', that.timerID, {best:that.time});
  // riotux.action('timerList', 'saveAll');
  // that.savestat();
// };

this.savestat = () => {
  let nowD = Date.now()/1;
  that.timerOBJ.timeline[nowD] = that.time;
  saveLevel(that.timerID, that.timerOBJ);
};

this.redo = () => {
  if(!that.running) return;
  let timeNow = Date.now();
  that.time = (timeNow-that.startTime)+that.lastTime;
  that.update();
  setTimeout(that.redo, that.freq);
};

this.moveUp = () => {
  let canI = riotux.action('main', 'moveItemUp', that.timerID);
  console.log(`move up return ${canI}`);
};

this.moveDown = () => {
  let canI = riotux.action('main', 'moveItemDown', that.timerID);
  console.log(`move down return ${canI}`);
};

this.toggleStats = () => {
  that.showChart = (that.showChart||that.showChart==='true'||false)? false : true;
};

this.toggleTable = () => {
  that.showTimeTable = (that.showTimeTable||that.showChart==='true'||false)? false : true;
};

this.on("update", () => {
  if(that.time>that.timerOBJ.best) {
    that.timeisred = true;
  } else {
    that.timeisred = false;
  }
  that.editMode = (that.opts.editmode||that.opts.editmode==="true"||false);
});

this.on("mount", () => {
  that.timerOBJ = loadLevel(that.timerID);
});

// this.on('unmount', () => {
//   riotux.unsubscribe(that);
//   console.log('hit main umount '+that.timerID);
// });

// riotux.subscribe(that, 'main', ( state, state_value ) => {
//   that.update();
//   console.log('hit main update '+that.timerID);
// });


</script>

</timer>