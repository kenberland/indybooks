<template>
<div class='indy-modal'>
  <nav class='panel'>
    <div class='indy-modal-header panel-heading'>
      <div><h4>Buy Local: {{ productName }}</h4></div>
    </div>
    <template v-for="store in stores">
      <a class='panel-block' v-if="store.ask">
        <store :store="store" />
      </a>
    </template>
    <template v-if="stores.length === 0">
      <a class='panel-block'>
        <h1> add a local store! </h1>
      </a>
    </template>
  </nav>
</div>
</template>

<script lang="ts">
import Vue from 'vue';
import axios from 'axios';
import Store from './Store.vue';

export default Vue.extend({
  name: 'BuyModal',
  components: { Store },
  props: {
    isbn: String,
    stores: Array,
    productName: String,
  },
});
</script>

<style scoped>
.indy-modal {
  width: 650px;
  margin: 0px auto;
  background-color: #fff;
  border-radius: 2px;
  box-shadow: 0 2px 8px 3px;
  transition: all 0.2s ease-in;
  font-family: Helvetica, Arial, sans-serif;
}

.indy-modal-header {
  background: #d3d3d3;
  border-radius: 2px;
  line-height: 16px;
  padding-left: 20px;
}

.indy-modal-header h4{
  font-size: 1em;
}

a:hover{
    text-decoration: none;
}
</style>
