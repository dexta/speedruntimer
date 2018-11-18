const oldMutation = {
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
      
  }