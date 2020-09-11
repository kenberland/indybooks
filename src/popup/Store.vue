<template>
<div class='store columns is-mobile'>
  <div class='column store-details is-7'>
    <div class='store-name'>
      <h4>{{ store.name }}</h4>
    </div>
    <div class='store-address'>
      {{ store.address }}
    </div>
  </div>
  <div class='column store-switch is-3'>
    <b-switch v-model="isLocal" type="is-indySuccess" @input="setLocal" />
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
    const syncedStores:any[] = [];
    return {
      isLocal: false,
      hasBeenStored: false,
      syncedStores,
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
          if (this.store.lat === item.lat && this.store.long === item.long) {
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
          if (this.store.lat === item.lat && this.store.long === item.long) {
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
    .column {
        padding: 15px;
    }
}

.store-address {
    font-size: 0.75em;
}
</style>
