<template>
  <div class='indy-modal'>
    <h1>Hi</h1>
    <p>List of books here plz</p>
    <div v-for="store in stores" :key="store.name">
      {{ store.name }}
    </div>
  </div>
</template>

<script lang="ts">
import Vue from 'vue';

export default Vue.extend({
  name: 'BuyModal',
  props: ['stores'],
});
</script>

<style scoped>
.indy-modal {
  width: 500px;
  margin: 0px auto;
  padding: 20px;
  background-color: #fff;
  border-radius: 2px;
  box-shadow: 0 2px 8px 3px;
  transition: all 0.2s ease-in;
  font-family: Helvetica, Arial, sans-serif;
}
</style>
