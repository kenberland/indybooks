<template>
<div>
  <div class='container'>
    <div class='search-container'>
       <!-- eslint-disable-next-line max-len -->
       <the-mask class='search-input' :mask="'#####'"  placeholder='Search by Zip' v-model.number="zip" @input="getStores" />
    </div>
  </div>
  <div class='store-container' v-for="store in stores" :key="store.name">
    <store :store="store" />
  </div>
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
    return {
      zip: '',
      stores: [],
    };
  },
  methods: {
    getStores(): void {
      if (this.zip.toString().length === 5) {
        axios
          .get('https://api.indybooks.net/v2')
          .then((response) => {
            this.stores = response.data.stores;
            console.log(response);
          })
          .catch((error) => {
            console.log(error);
          });
      }
    },
  },
});
</script>

<style lang="scss">
.container {
    background-color: #e7e7e7;
    border-bottom: 1px solid #e7e7e7;
    height: 50px;
    line-height: 30px;
}
.search-container {
    padding: 12px 18px;
}
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
