const defaultTimerList = {
    theme: "SuperMeatBoy",
    timerList: [
      {id:'smbc1lw',name:'Chapter 1 - Light World',time:0,best:24143423},
      {id:'smbc1dw',name:'Chapter 1 - Dark World',time:0,best:24143423},
      {id:'smbc2lw',name:'Chapter 2 - Light World',time:0,best:24143423},
      {id:'smbc2dw',name:'Chapter 2 - Dark World',time:0,best:24143423},
      {id:'smbc3lw',name:'Chapter 3 - Light World',time:0,best:24143423},
      {id:'smbc3dw',name:'Chapter 3 - Dark World',time:0,best:24143423},
      {id:'smbc4lw',name:'Chapter 4 - Light World',time:0,best:24143423},
      {id:'smbc4dw',name:'Chapter 4 - Dark World',time:0,best:24143423},
    ]
  };

  let store = riotux.Store({
    state: {
      
      allTime: 0,
      timerList: [],
      listOfTimes: {},
      theme: 'SuperMeatBoy',
      // new struck
      mainTreeName: 'speedrunners'
      loadedLevel: {},
      main: {
        "activeTheme": "Super Meat Boy",
        "themeList": [
          {"name":"Super Meat Boy","level":["smbc1lw","smbc1dw","smbc2lw","smbc2dw","smbc3lw","smbc3dw","smbc4lw","smbc4dw","smbc5lw","smbc5dw"]},
          {"name":"Great Giana Sisters","level":["ggslevel01","ggslevel02","ggslevel03","ggslevel04","ggslevel05","ggslevel06","ggslevel07"]}
        ]
      },
      "timeslist": {
        "smbc1lw": {
          "name": "Chapter 1 - Light World",
          "timeline": {
            "1541099353543":574395,"1541103682925":638715,"1541181562021":681252,"1541441368948":651999,"1541887420053":402965,"1541954795453":463479
          },
          "best":402965,"bgcolor":"bg-light"
        }
      }
    // end of new data struc
    },
    mutations: {
      loadTimerList: (state, themeName) => {
        let fromLocal = (themeName&&localStorage.getItem(themeName)||false)? JSON.parse(localStorage.getItem(themeName)) : defaultTimerList;
        state.allTime = 0;
        state.theme = fromLocal.theme;
        state.timerList = fromLocal.timerList;
      },
      saveTimerList: (state) => {
        let toLocal = JSON.stringify({theme:state.theme,timerList:state.timerList});
        localStorage.setItem(state.theme,toLocal);
      },
      updateById: (state, id, upObj) => {
        for(let s in state.timerList) {
          if(state.timerList[s].id===id) {
            for(let u in upObj) {
              state.timerList[s][u] = upObj[u];
            }
            break;
          }
        }
      },
      addAllTime: (state,timeToAdd) => {
        state.allTime+= timeToAdd;
      },
      moveUpInList: (state, id) => {
        let index = state.timerList.map( e => { return e.id } ).indexOf(id);
        if(index<=0) {
          return (index===-1)? 'index not found' : 'index to low';
        }
        state.timerList.splice(index, 0, state.timerList.splice(index-1,1)[0]);
      },
      moveDownInList: (state, id) => {
        let index = state.timerList.map( e => { return e.id } ).indexOf(id);
        if(index===state.timerList.length-1) {
          return 'index to high';
        }
        state.timerList.splice(index+1, 0, state.timerList.splice(index,1)[0]);        
      },
      moveInList: (state, id, dir) => {
        let index = state.timerList.map( e => { return e.id } ).indexOf(id);
        if(index===-1) {
          return "index not found";
        } else if(index===0&&dir==="UP") {
          return "index to low";
        } else if(index===state.timerList.length-1&&dir==="DOWN") {
          return "index to high";
        }
        let to = (dir==="UP")? index-1 : index+1;
        state.timerList.splice(to, 0, state.timerList.splice(index,1)[0]);
      },
      updateTimeOfItem: (state, id, time) => {
        let rawLocal = localStorage.getItem(id)||'{}';
        let fromLocal = (rawLocal||false)? JSON.parse(rawLocal) : {};
        fromLocal[Date.now()] = time;
        state.listOfTimes[id] = fromLocal;
        let toLocal = JSON.stringify(fromLocal);
        localStorage.setItem(id, toLocal);
      },
      loadTimeOfItem: (state,id) => {
        if(!(state.listOfTimes[id]||false)) {
          let rawLocal = localStorage.getItem(id)||'{}';
          let fromLocal = (rawLocal||false)? JSON.parse(rawLocal) : {};
          state.listOfTimes[id] = fromLocal;
        }
        return state.listOfTimes[id];
      },
      saveTimeOfItemBlob: (state, id, toSaveObj) => {
        if(!(toSaveObj||false)) return;
        state.listOfTimes[id] = toSaveObj;
        localStorage.setItem(id, JSON.stringify(toSaveObj));
      },
      // 
      // new mutation here
      // 
      loadMainTree: (state) => {
        let rawMain = localStorage.getItem(state.mainTreeName);
        if(!rawMain) {
          console.log("there is nothing to load do some default some time");
        } else {
          let testObj = JSON.parse(rawMain);
          if(!testObj.themeList||false) return "data are wrong";
          state.main = testObj;
        }
      },
      saveMainTree: (state) => {
        localStorage.setItem(state.mainTreeName, JSON.stringify(state.main) );
      },
      loadThemeList: (state, themeName) => {
        if(!state.main.themeList||false) return "no main stat loaded";
        for(let t in state.main.themeList) {
          if(state.main.themeList[t].name===themeName) {
            state.main.loadedLevel = state.main.themeList[t];
            break;
          }
        }
      },
      
      // 
      // end of new mutation here
      // 
    }
  });

  let action = riotux.Actions({
    loadAll: (store, name) => {
      store.dispatch('loadTimerList', name);
    },
    saveAll: (store) => {
      store.dispatch('saveTimerList');
    },
    updateTimer: (store, id, updateObj) => {
      store.dispatch('updateById', id, updateObj);
    },
    moveItemUp: (store, id) => {
      return store.dispatch('moveInList', id, "UP");
    },
    moveItemDown: (store, id) => {
      return store.dispatch('moveInList', id, "DOWN");
    },
    updateTime: (store, id, time) => {
      store.dispatch('updateTimeOfItem', id, time);
    },
    loadTime: (store, id) => {
      return store.dispatch('loadTimeOfItem', id);
    },
    saveTimeBlob: (store, id, timesObj) => {
      return store.dispatch('saveTimeOfItemBlob', id, timesObj);
    }
  });
  // riotux.action('timerList', 'saveAll');
  // riotux.action('timerList', 'updateTimer', 'smbc3lw', {best:64223});
  // riotux.action('listOfTimes', 'updateTime', id, time);
  riotux.action('timerList', 'loadAll', 'SuperMeatBoy');

<!-- tmp scripts remove after useing -->

const genSomeTimes = () => {
  store.state.timerList.forEach( (e,i) => { 
    let toSave = {};
    start = 1530008489878+parseInt(Math.random()*(100000*(i+1)));
    for(let rd=1;rd<=10;rd++) {
      start += parseInt(Math.random()*(10000000*rd));
      timeSpend = parseInt(Math.random()*1000000)+(50044*(i*i+1));
      toSave[start] = timeSpend;
    }
    let toLocal = JSON.stringify(toSave);
    localStorage.setItem(e.id, toLocal);
  });
}

const saveDataVersionOne = (themeName) => {
  if(!themeName||false) return;
  let dataMainTree = JSON.parse(localStorage.getItem(themeName));
  let timeingList = {};
  for(let t in dataMainTree.timerList) {
    let item = dataMainTree.timerList[t];
    let tmpRaw = JSON.parse(localStorage.getItem(item.id));
    timeingList[item.id] = tmpRaw;
  }
  let out = {main: dataMainTree, list: timeingList};
  console.dir(out);
  console.log(JSON.stringify(out));
}
