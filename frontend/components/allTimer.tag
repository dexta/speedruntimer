<alltimer>
<span each={el,ind in listOfTimers}>
  <timer name="{el.name}" namedid="{el.id}" besttime="el.best">
  <hr/>
</span>
<script>
let that = this;
this.listOfTimers = [];

riotux.subscribe(that, 'timerList', ( state, state_value ) => {
  that.listOfTimers = riotux.getter('timerList');
  that.update();
});


</script>

</alltimer>