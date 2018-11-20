let action = riotux.Actions({
    initLoad: (store) => {
      store.dispatch('loadMainTree');
    },
    moveItemUp: (store, id) => {
      return store.dispatch('moveLevelInList', id, "UP");
    },
    moveItemDown: (store, id) => {
      return store.dispatch('moveLevelInList', id, "DOWN");
    },
  });
  // riotux.action('timerList', 'saveAll');
  // riotux.action('timerList', 'updateTimer', 'smbc3lw', {best:64223});
  // riotux.action('listOfTimes', 'updateTime', id, time);
  // riotux.action('timerList', 'loadAll', 'SuperMeatBoy');