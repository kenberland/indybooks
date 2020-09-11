<template>
<div class='my-bookstores'>
  <a class='panel-block' v-for="store in stores" :key="store.name">
    <store :store="store" />
  </a>
</div>
</template>

<script lang="ts">
import Vue from 'vue';
import Store from './Store.vue';

export default Vue.extend({
  name: 'App',
  components: { Store },
  data() {
    const stores:any[] = [];
    return {
      zip: '',
      stores,
    };
  },
  beforeMount() {
    browser.storage.sync.get(['indystores']).then((obj: any) => {
      if (obj.indystores !== undefined) {
        obj.indystores.stores.forEach((item: any) => {
          this.stores.push(item);
        });
      }
    });
  },
});
</script>

<style lang="scss">
.panel-heading {
    .search-stores {
        float: right;
        background-color: transparent;
        border-color: transparent;
        padding-bottom: 15px;
        &:hover {
            border-color: transparent;
        }
        &:focus {
            box-shadow: none;
            border-color: transparent;
            &:not(:active) {
                box-shadow: none;
            }
        }
    }
}
</style>
