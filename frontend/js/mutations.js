const newMutation = {
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
          for(let tl in state.main.themeList) {
            if(state.main.themeList[tl].name===state.main.activeTheme) {
              state.loadedLevel = state.main.themeList[tl].level;
              for(let le in state.main.themeList[tl].level) {
                let tmraw = JSON.parse(localStorage.getItem(state.main.themeList[tl].level[le]));
                if(tmraw.name||false) {
                  state.timeslist[state.main.themeList[tl].level[le]] = tmraw;
                }
              }
              console.log("theme list index "+state.main.themeList[tl].level);
            }
          }
        }
      },
      saveMainTree: (state) => {
        localStorage.setItem(state.mainTreeName, JSON.stringify(state.main) );
      },
      exportAll: (state) => {
        return {main: state.main, timeslist: state.timeslist};
      },
      importAll: (state, allNew) => {
        if(!allNew.main||false) {
          allNew = JSON.parse(allNew);
          if(!allNew.main||false) return "no importable object";
        }
        state.main = allNew.main;
        state.timeslist = (allNew.timeslist||false)? allNew.timeslist : {};
      },
      loadThemeList: (state, themeName) => {
        if(!state.main.themeList||false) return "no main stat loaded";
        for(let t in state.main.themeList) {
          if(state.main.themeList[t].name===themeName) {
            state.loadedLevel = state.main.themeList[t];
            break;
          }
        }
      },
      // loadLevelTime: (state, levelID) => {
      //   if(state.timeslist[levelID]||false) {
      //     return state.timeslist[levelID];
      //   } else {
      //     let rawLocal = JSON.prase(localStorage.getItem(levelID));
      //     if(!rawLocal.name||false) return "your time is brocken";
      //     state.timeslist[levelID] = rawLocal;
      //     return state.timeslist[levelID];
      //   }
      // },
      saveLevelTime: (state, levelID, fullLvlObj) => {
        if(!fullLvlObj||false) return "error in full Level Obj";
        let objStr = JSON.stringify(fullLvlObj);
        localStorage.setItem(levelID, fullLvlObj);
      },
      addLevelTime: (state, levelID, newTime) => {
        // let newTime = { date-timestamp, time/ms };
        if(!state.timeslist[levelID]||false) return "load the level first";
        if(newTime.time < state.timeslist[levelID].best) state.timeslist[levelID].best = newTime.time;
        state.timeslist[levelID].timeline[newTime.date] = newTime.time;
      },
      moveLevelInList: (state, id, dir) => {
        let index = state.loadedLevel[state.main.activeTheme].map( e => { return e.id } ).indexOf(id);
        if(index===-1) {
          return "index not found";
        } else if(index===0&&dir==="UP") {
          return "index to low";
        } else if(index===state.loadedLevel.length-1&&dir==="DOWN") {
          return "index to high";
        }
        let to = (dir==="UP")? index-1 : index+1;
        state.loadedLevel.splice(to, 0, state.loadedLevel.splice(index,1)[0]);
      },
      // 
      // end of new mutation here
      // 
    }
  // }