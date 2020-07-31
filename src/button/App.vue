<template>
<buy-button v-if="isbn" :isbn="isbn" />
</template>

<script lang="ts">
import Vue from 'vue';
import BuyButton from './BuyButton.vue';

const productDetails = document.getElementById('productDetailsTable');
const allChildren = productDetails.getElementsByTagName('*');
let found;

for (let i = 0; i < allChildren.length; i += 1) {
  if (allChildren[i].textContent === 'ISBN-10:') {
    found = allChildren[i];
    break;
  }
}
const isbn = found.nextSibling.textContent;

export default Vue.extend({
  name: 'IndyBooks',
  components: { BuyButton },
  data() {
    return {
      isbn: isbn || '',
    };
  },
});

</script>

<style>
</style>
