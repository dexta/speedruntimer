<statTimeEdit>
<h1>{chartTitle}</h1>
<table class="table table-striped">
  <tr>
    <th scope="col">Action</th>
    <th scope="col">Time of stop</th>
    <th scope="col">spend time</th>
  </tr>
  <tr each={ val,inx in timeToEdit }>
    <td>
      <button class="btn btn-danger">
        <i class="fa fa-remove"></i>
      </button>
      <button class="btn btn-info">
        <i class="fa fa-edit"></i>
      </button>
    </td>
    <td>{formatDate(inx)}</td>
    <td>{formatTime(val)}</td>
  </tr>
</table>

<script>
let that = this;

this.chartIndex = this.opts.cindex;
this.chartTitle = this.opts.ctitle;

this.listOfTimes = {};

this.getListOfTimers = () => {
  that.listOfTimes = riotux.getter('listOfTimes');
  if(that.listOfTimes['smbc1lw']||false) {
    that.timeToEdit = that.listOfTimes['smbc1lw'];
    that.update();
  }
}

this.formatDate = (milsec) => {
  // return () => {
    return moment(parseInt(milsec)).format("YYYY:MM:DD HH:mm:ss");
  // };
};

this.formatTime = (toHumanTime) => {
  let tis = Math.floor(toHumanTime/1000);
  let mil = toHumanTime%tis||0;

  let sec = ("0"+Math.floor(tis%3600%60||0)).slice(-2);
  let min = ("0"+Math.floor(tis%3600/60||0)).slice(-2);
  let std = ("0"+Math.floor(tis/3600||0)).slice(-2);

  return `${std}:${min}:${sec}:${mil}`;
};


this.on("mount",()=>{
  that.listOfTimes = riotux.action('listOfTimes','loadTime','smbc1lw');
  // that.getListOfTimers();
});

riotux.subscribe(that, 'listOfTimes', ( state, state_value ) => {
  console.dir(state_value);
  that.getListOfTimers();
});

</script>

</statTimeEdit>
