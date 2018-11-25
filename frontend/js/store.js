// const MergedMutations = Object.assign({},oldMutation, newMutation);

let store = riotux.Store({
  state: {
    mainTreeName: 'speedrunners',
    main: {},
  },
  mutations: {
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
    moveLevelInList: (state, id, dir) => {
      let theme = state.main.themeList.map( e => { return e.name } ).indexOf(state.main.activeTheme);
      let index = state.main.themeList[theme].level.indexOf(id);
      if(index===-1) {
        return "index not found";
      } else if(index===0&&dir==="UP") {
        return "index to low";
      } else if(index===state.main.themeList[theme].level.length-1&&dir==="DOWN") {
        return "index to high";
      }
      let to = (dir==="UP")? index-1 : index+1;
      state.main.themeList[theme].level.splice(to, 0, state.main.themeList[theme].level.splice(index,1)[0]);
      return "move "+dir+" to index "+to;
    },
  }
});