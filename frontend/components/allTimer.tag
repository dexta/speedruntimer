<alltimer>
<div class="row">
  <div class="col-3">
    <b class="h5">{main.activeTheme}</b>
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
  <button class="btn btn-primary pull-right" show={editActive} onclick={ toggleIE }>
    <i class="fa fa-file"></i> | 
    Import / Export
  </button>
  </div>
</div>
<span show={importExportShow}>
  <hr>
  <importexport class="row"></importexport>
</span>
<hr>
<span each={el,ind in loaded}>
  <timer namedid="{el}" editmode="{editActive}" id="htmlID_{ind}">
  <hr/>
</span>

<script>
let that = this;
this.main = {};
this.loaded = {};
this.themeName = "";

this.importExportShow = false;

this.editActive = false;

this.getListOfTimers = () => {
  that.main = riotux.getter('main');
  that.themeName = that.main.activeTheme;
  let tInx = that.main.themeList.map( e=> { return e.name } ).indexOf(that.themeName);
  that.loaded = that.main.themeList[tInx].level;
  that.update();
}

this.toggleEdit = () => {
  that.editActive = (that.editActive||false)? false : true;
  that.update();
};

this.toggleIE = () => {
  that.importExportShow = (that.importExportShow||false)? false : true;
  that.update();
};

this.saveAll = () => {
  console.log(`Save ${that.main.activeTheme} count: ${that.loaded.length}`);
  saveMain();
};

riotux.subscribe(that, 'main', ( state, state_value ) => {
  that.getListOfTimers();
});

this.on('mount', () => {
  riotux.action('main','initLoad');
  that.getListOfTimers();
});

</script>
</alltimer>