<template>
<div class='container'>
  <nav class='panel'>
    <div class='panel-heading'>
       <!-- eslint-disable-next-line max-len -->
       <the-mask class='search-input' :mask="'#####'"  placeholder='Search by Zip' v-model.number="zip" @input="getStores" />
    </div>
    <a class='panel-block' v-for="store in stores" :key="store.name">
      <store :store="store" />
    </a>
  </nav>
</div>
</template>

<script lang="ts">
import Vue from 'vue';
import axios from 'axios';
import { TheMask } from 'vue-the-mask';
import Store from './Store.vue';

export default Vue.extend({
  name: 'App',
  components: { Store, TheMask },
  data() {
    const stores:any[] = [];
    return {
      zip: '',
      stores,
    };
  },
  methods: {
    getStores(): void {
      if (this.zip.toString().length === 5) {
        browser.storage.sync.set({ indystoresZip: this.zip });

        axios
          .get('https://api.indybooks.net/v4/stores')
          .then((response) => {
            response.data.stores.forEach((item: any) => {
              let foundStore = false;

              this.stores.forEach((store: any) => {
                if (store.id === item.id) {
                  foundStore = true;
                }
              });

              if (!foundStore) {
                this.stores.push(item);
              }
            });
          })
          .catch((error) => {
            console.log(error);
          });
      }
    },
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
.search-input {
    background-color: transparent;
    border: none;
    outline: none;
    font-size: normal;
    background-image: url("../assets/images/Search.png");
    background-repeat: no-repeat;
    background-size: 17px;
    padding-left: 40px;
}
</style>
