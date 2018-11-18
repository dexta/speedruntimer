const loadLevel = (levelID) => {
  let ttest = localStorage.getItem(levelID);
  if(!ttest||false) return "can not found the entry with key "+levelID;
  let tjson = JSON.parse(ttest);
  if(tjson.name!="") {
    return tjson;
  } else {
    return {};
  }
};

const saveLevel = (levelID,levelData) => {
  levelData[id] = levelID;
  levelData.best = (levelData.best||false)? parseInt(levelData.best) : 24143423;
  for(let ts in levelData.timeline) {
    if(levelData.best>levelData.timeline[ts]) {
      levelData.best = levelData.timeline[ts];
    }
  }
  let tstr = JSON.stringify(levelData);
  return localStorage.setItem(levelID, levelData);
};