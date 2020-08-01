<template>
<div class='store columns is-mobile'>
  <div class='column is-6 is-offset-1'>
    <div class='store-name'>
      <h4>{{ store.name }}</h4>
    </div>
    <div class='store-address'>
      {{ store.address }}
    </div>
  </div>
  <div class='column is-3 is-offset-2'>
    <div class='indy-button'>
      <div class='indy-text'>
        Buy Local!
      </div>
    </div>
  </div>
</div>
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
.store {
    width: 100%;
}
</style>
