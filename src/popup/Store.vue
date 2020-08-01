<template>
<div class='store columns is-mobile'>
  <div class='column is-7'>
    <div class='store-name'>
      <h4>{{ store.name }}</h4>
    </div>
    <div class='store-address'>
      {{ store.address }}
    </div>
  </div>
  <div class='column is-3 is-offset-2'>
    <b-switch v-model="isLocal" @input="setLocal" />
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
  data() {
    return {
      isLocal: '',
    };
  },
  methods: {
    setLocal(): void {
      debugger;
      const indyStores = chrome.storage.sync.get(['indystores'], (obj) => {
        obj.indystores.stores.forEach((item, index) => {
          debugger;
        });
      });
    },
  },
});
</script>

<style lang="scss">
.store {
    width: 100%;
}
.store-address {
    font-size: 0.75em;
}
</style>
