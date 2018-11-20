<statTimeEdit>
<table class="table table-striped">
  <tr>
    <th scope="col">
      <button hide={doEditLine[-42]} class="btn btn-dark pull-left" onclick={editTime(-42)}>
        <i class="fa fa-edit"></i>
      </button>
      <button show={doEditLine[-42]} class="btn btn-danger" onclick={saveTime(-42)}>
        <i class="fa fa-save"></i>
      </button>
    </th>
    <th colspan="2">
      <h1 hide={doEditLine[-42]}>{chartTitle}</h1>
      <input show={doEditLine[-42]} type="text" class="form-control" ref="timestamp_-42" value={chartTitle}>
    </th>
  </tr>
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
    <td hide={doEditLine[inx]}>{formatTimeSpend(val)}</td>
    <td show={doEditLine[inx]}>
      <input type="text" class="form-control" ref="timespend_{inx}" value={val}>
    </td>
  </tr>
</table>

<script>
let that = this;

this.chartIndex = this.opts.cindex;
this.chartTitle = this.opts.ctitle||"default Title";

this.formatTimeSpend = formatTimeSpend;
this.formatDate = formatDate;

this.timeToEdit = {};

this.listOfTimes = {};
this.doEditLine = {};

this.getTimeData = () => {
  that.listOfTimes = loadLevel(that.chartIndex);
  that.timeToEdit = that.listOfTimes.timeline;
  that.chartTitle = that.listOfTimes.name;
  that.doEditLine = {};  
  // console.dir(that.timeToEdit);
  that.update();
};

this.removeTime = (indexNo) => {
  return () => {
    if(that.timeToEdit[indexNo]||false) {
      delete that.timeToEdit[indexNo];
      // riotux.action('listOfTimes','saveTimeBlob','smbc1lw',that.timeToEdit);
      that.listOfTimes.timeline = that.timeToEdit;
      saveLevel(that.chartIndex, that.listOfTimes);
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
    let newTimespend = 0;
    that.doEditLine[indexNo] = false;
    if(indexNo===-42) {
      if(that.chartTitle===newTimestamp) return;
      that.listOfTimes.name = newTimestamp;
      that.chartTitle = newTimestamp;
      saveLevel(that.chartIndex, that.listOfTimes);
      return;
    } else {
      newTimespend = that.refs["timespend_"+indexNo].value;
      that.listOfTimes.timeline = that.timeToEdit;
      saveLevel(that.chartIndex, that.listOfTimes);
      return;
    }
    
    console.log(newTimestamp,newTimespend);
  }
}

this.on("mount",()=>{
  that.getTimeData();
});
</script>

</statTimeEdit>
