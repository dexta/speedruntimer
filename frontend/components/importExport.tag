<importexport>
<div class="col-4">
  <b>Import Export:</b>
</div>
<div class="col-6">
  <button class="btn btn-primary" onclick={ exportToText }>
    export
  </button>
  <button class="btn btn-info" onclick={ importFromText }>
    import
  </button>
</div>

<div class="col-12">
  <textarea ref="textinout"></textarea>
</div>


<script>
let that = this;

let testJSONstr = JSON.stringify({"main":{"activeTheme":"Super Meat Boy","themeList":[{"name":"Super Meat Boy","level":["smbc1lw","smbc2lw","smbc1dw","smbc2dw","smbc3lw","smbc3dw","smbc4lw","smbc4dw","smbc5lw","smbc5dw"]},{"name":"Great Giana Sisters","level":["ggslevel01","ggslevel02","ggslevel03","ggslevel04","ggslevel05","ggslevel06","ggslevel07"]}]},"level":{"smbc1lw":{"name":"Chapter 1 - Light World","timeline":{"1541099353543":574395,"1541103682925":638715,"1541181562021":681252,"1541441368948":651999,"1541887420053":402965,"1541954795453":463479},"best":402965,"bgcolor":"bg-light","id":"smbc1lw"},"smbc1dw":{"name":"Chapter 1 - Dark World","timeline":{"1541099353543":1227282,"1541961033323":675090},"best":675090,"bgcolor":"bg-secondary"},"smbc2lw":{"name":"Chapter 2 - Light World","timeline":{"1541099353543":947066,"1541196432539":835330,"1541442303914":892564,"1541888383915":933500,"1541955768523":812805},"best":812805,"bgcolor":"bg-light"},"smbc2dw":{"name":"Chapter 2 - Dark World","timeline":{"1541099353543":24143423,"1541795880286":2079889,"1541962520202":1299225},"best":1299225,"bgcolor":"bg-secondary"},"smbc3lw":{"name":"Chapter 3 - Light World","timeline":{"1541099353543":1233190,"1541793285783":1232451,"1541964063275":798974},"best":798974,"bgcolor":"bg-light"},"smbc3dw":{"name":"Chapter 3 - Dark World","timeline":{"1541099353543":24143423,"1541875158747":4431117,"1541885354043":4431117},"best":4431117,"bgcolor":"bg-secondary"},"smbc4lw":{"name":"Chapter 4 - Light World","timeline":{"1541876394098":1210118,"1541885348964":1210118},"best":1210118,"bgcolor":"bg-light"},"smbc4dw":{"name":"Chapter 4 - Dark World","timeline":{"1541099353544":24143423},"best":24143423,"bgcolor":"bg-secondary"},"smbc5lw":{"name":"Chapter 5 - Light World","timeline":{"1541099353544":24143423,"1541885344852":2282382},"best":2282382,"bgcolor":"bg-light"},"smbc5dw":{"name":"Chapter 5 - Dark World","timeline":{"1541099353544":24143423},"best":24143423,"bgcolor":"bg-secondary"}}});

this.exportToText = () => {
  let theMain = JSON.parse(localStorage.getItem("speedrunners"));
  let theLevel = {};
  if( (theMain.themeList||false) && (theMain.activeTheme||false) ) {
    for(let t in theMain.themeList) {
      for(let l in theMain.themeList[t].level) {
        let loadLevel = JSON.parse(localStorage.getItem(theMain.themeList[t].level[l]));
        if( (loadLevel||false)  && (loadLevel.name||false)) {
          theLevel[theMain.themeList[t].level[l]] = loadLevel;
        }
      }
    }
  }
  let expObj = { main: theMain, level: theLevel };
  console.dir(expObj);
  that.refs.textinout.value = JSON.stringify(expObj);
};

this.importFromText = () => {
  console.log("import from textarea first check if some missing");
  let rawText = that.refs.textinout.value;
  let rJson = JSON.parse(rawText);
  if(!rJson||false) console.log("can not read the json");
  console.dir(rJson);
  if( (rJson.main||false) && (rJson.level||false) ) {
    localStorage.setItem("speedrunners",JSON.stringify(rJson.main));
    for(let l in rJson.level) {
      localStorage.setItem(l, JSON.stringify(rJson.level[l]));
    }
    riotux.action('main','initLoad');
  } else {
    console.log("data not valid missing main or level");
  }
};

this.on('mount', ()=> {
  that.refs.textinout.value = testJSONstr;
});

</script>

<style>
textarea {
  width: 100%;
  height: 225px;
}
</style>
</importexport>