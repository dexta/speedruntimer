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
  levelData.id = levelID;
  levelData.best = (levelData.best||false)? parseInt(levelData.best) : 24143423;
  for(let ts in levelData.timeline) {
    if(levelData.best>levelData.timeline[ts]) {
      levelData.best = levelData.timeline[ts];
    }
  }
  let tstr = JSON.stringify(levelData);
  return localStorage.setItem(levelID, tstr);
};

const saveMain = () => {
  let main = riotux.getter('main');
  localStorage.setItem("speedrunners", JSON.stringify(main));
};

const formatTimeSpend = (toHumanTime) => {
  let tis = Math.floor(toHumanTime/1000);
  let mil = toHumanTime%tis||0;

  let sec = ("0"+Math.floor(tis%3600%60||0)).slice(-2);
  let min = ("0"+Math.floor(tis%3600/60||0)).slice(-2);
  let std = ("0"+Math.floor(tis/3600||0)).slice(-2);

  return `${std}:${min}:${sec}:${mil}`;
};

const formatDate = (timeinsec) => {
  return moment(parseInt(timeinsec)).format("YYYY:MM:DD HH:mm:ss");
};