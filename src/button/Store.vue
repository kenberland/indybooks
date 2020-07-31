<template>
<tr class='indy-store'>
  <td style='border-top: 1px solid #e7e7e7; padding-top: 0.5em;'> {{ store.name }} </td>
  <td style='border-top: 1px solid #e7e7e7; padding-top: 0.5em;'> {{ store.address }} </td>
  <td>
    <div class='indy-button'>
      <div class='indy-text'>
        Buy Local!
      </div>
    </div>
  </td>
</tr>
</template>

<script lang="ts">
import Vue from 'vue';

export default Vue.extend({
  name: 'Store',
  props: {
    store: Object,
  },
});
</script>

<style lang='scss' scoped>
@import '@/scss/indy-buttons.scss';
</style>
