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
      <button class="btn btn-danger" onclick={removeTime(inx)}>
        <i class="fa fa-remove"></i>
      </button>
      <button  hide={doEditLine[inx]} class="btn btn-info" onclick={editTime(inx)}>
        <i class="fa fa-edit"></i>
      </button>
      <button show={doEditLine[inx]} class="btn btn-danger" onclick={saveTime(inx)}>
        <i class="fa fa-save"></i>
      </button>
    </td>
    <td hide={doEditLine[inx]}>{formatDate(inx)}</td>
    <td show={doEditLine[inx]}>
      <input type="text" class="form-control" ref="timestamp_{inx}" value={inx}>
    </td>
    <td hide={doEditLine[inx]}>{formatTime(val)}</td>
    <td show={doEditLine[inx]}>
      <input type="text" class="form-control" ref="timespend_{inx}" value={val}>
    </td>
  </tr>
</table>

<script>
let that = this;

this.chartIndex = this.opts.cindex;
this.chartTitle = this.opts.ctitle;

this.listOfTimes = {};
this.doEditLine = {};

this.getListOfTimers = () => {
  that.listOfTimes = riotux.getter('listOfTimes');
  if(that.listOfTimes['smbc1lw']||false) {
    that.timeToEdit = that.listOfTimes['smbc1lw'];
    that.update();
  }
}

this.formatDate = (milsec) => {
    return moment(parseInt(milsec)).format("YYYY:MM:DD HH:mm:ss");
};

this.formatTime = (toHumanTime) => {
  let tis = Math.floor(toHumanTime/1000);
  let mil = toHumanTime%tis||0;

  let sec = ("0"+Math.floor(tis%3600%60||0)).slice(-2);
  let min = ("0"+Math.floor(tis%3600/60||0)).slice(-2);
  let std = ("0"+Math.floor(tis/3600||0)).slice(-2);

  return `${std}:${min}:${sec}:${mil}`;
};

this.removeTime = (indexNo) => {
  return () => {
    if(that.timeToEdit[indexNo]||false) {
      delete that.timeToEdit[indexNo];
      riotux.action('listOfTimes','saveTimeBlob','smbc1lw',that.timeToEdit);
    }
    console.log("click remove time from index "+indexNo);
    }
}

this.editTime = (indexNo) => {
  return () => {
    console.log("click edit time from index "+indexNo);
    that.doEditLine[indexNo] = true;
    // that.update();
    }
}

this.saveTime = (indexNo) => {
  return () => {
    // riotux.action('listOfTimes','saveTimeBlob','smbc1lw',that.timeToEdit);
    let newTimestamp = that.refs["timestamp_"+indexNo].value;
    let newTimespend = that.refs["timespend_"+indexNo].value;
    console.log(newTimestamp,newTimespend);
  }
}

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
