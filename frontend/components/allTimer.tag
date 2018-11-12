<alltimer>
<div class="row">
  <div class="col-3">
    <b class="h5">{themeName}</b>
  </div>
  <div class="col-5">
    <button class="btn btn-dark" onclick={ toggleEdit }>
      <i class="fa fa-cog"></i> | 
      Options / Edit
    </button>
  </div>
  <div class="col-4">
  <button class="btn btn-danger pull-right" show={editActive} onclick={ saveAll }>
    <i class="fa fa-save"></i> | 
    Save
  </button>
  </div>
</div>
<hr>
<span each={el,ind in listOfTimers}>
  <timer name="{el.name}" namedid="{el.id}" besttime="{el.best}" bgc="{el.bgcolor}" editmode="{editActive}">
  <hr/>
</span>

<script>
let that = this;
this.listOfTimers = [];
this.themeName = "";
this.editActive = false;

this.getListOfTimers = () => {
  that.listOfTimers = riotux.getter('timerList');
  that.themeName = riotux.getter('theme');
  that.update();
}

this.toggleEdit = () => {
  console.log("test etst");
  that.editActive = (that.editActive||false)? false : true;
  that.update();
};

this.saveAll = () => {
  riotux.action('timerList', 'saveAll');
  console.log(`Save ${that.themeName} count: ${that.listOfTimers.length}`);
};

riotux.subscribe(that, 'timerList', ( state, state_value ) => {
  that.getListOfTimers();
});

this.on('mount', () => {
  that.getListOfTimers();
});

</script>
</alltimer>