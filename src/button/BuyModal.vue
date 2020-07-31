<template>
<div class='indy-modal'>
  <header class='indy-modal-header'>
    <div><h4>Buy Local: {{ productName }}</h4></div>
  </header>
  <div class='indy-modal-body'>
    <table>
      <thead>
        <tr>
          <th style='padding-bottom: 1em;'>Store Name</th>
          <th style='padding-bottom: 1em;'>Address</th>
          <th style='padding-bottom: 1em;'></th>
        </tr>
      </thead>
      <tbody v-for="store in stores" :key="store.name">
        <store :store="store" />
      </tbody>
    </table>
  </div>
</div>
</template>

<script lang="ts">
import Vue from 'vue';
import Store from './Store.vue';

export default Vue.extend({
  name: 'BuyModal',
  components: { Store },
  props: {
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

.indy-modal-body {
  padding: 20px;
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
</style>
