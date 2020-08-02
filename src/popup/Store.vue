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
      isLocal: false,
      hasBeenStored: false,
      syncedStores: Array(),
    };
  },
  methods: {
    setLocal(): void {
      browser.storage.sync.get(['indystores']).then((obj: any) => {
        this.hasBeenStored = false;

        if (obj.indystores !== undefined) {
          this.syncedStores = obj.indystores.stores;
        }

        this.syncedStores.forEach((item: any, index: number) => {
          if (item.id === this.store.id) {
            if (!this.isLocal) {
              this.syncedStores.splice(index, 1);
            }
            this.hasBeenStored = true;
          }
        });

        if (this.isLocal && !this.hasBeenStored) {
          this.syncedStores.push(this.store);
        }

        browser.storage.sync.set({ indystores: { stores: this.syncedStores } });
      });
    },
  },
  beforeMount() {
    browser.storage.sync.get(['indystores']).then((obj: any) => {
      if (obj.indystores !== undefined) {
        obj.indystores.stores.forEach((item: any) => {
          if (item.id === this.store.id) {
            this.isLocal = true;
          }
        });
      } else {
        this.isLocal = false;
      }
    });
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
