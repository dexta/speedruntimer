let action = riotux.Actions({
    // 
    // new actions here
    // 
    initLoad: (store) => {
      store.dispatch('loadMainTree');
    },
    saveMainAll: (store) => {
      store.dispatch('saveMainTree');
    },
    loadLevel: (store, levelName) => {
      store.dispatch('loadThemeList',levelName);
    },
    // loadLevelDetails: (store, levelID) => {
    //   return store.dispatch('loadLevelTime', levelID);
    // },
    allToJson: (store) => {
      return store.dispatch('exportAll');
    },
    allFromJson: (store, jsonObj) => {
      return store.dispatch('importAll', jsonObj);
    },
    addTime: (store, levelID, newTime) => {
      store.dispatch('addLevelTime', levelID, newTime);
      store.dispatch('saveLevelTime', levelID, store.state.loadedLevel[levelID]);
    },
    // 
    // end new actions here
    // 
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
