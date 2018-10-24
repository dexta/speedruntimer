<alltimer>
<span each={el,ind in listOfTimers}>
  <timer name="{el.name}" namedid="{el.id}" besttime="{el.best}">
  <hr/>
</span>
<script>
let that = this;
this.listOfTimers = [];

this.getListOfTimers = () => {
  that.listOfTimers = riotux.getter('timerList');
  that.update();
}


riotux.subscribe(that, 'timerList', ( state, state_value ) => {
  that.getListOfTimers();
});


this.on('mount', () => {
  that.getListOfTimers();
});

</script>

</alltimer>