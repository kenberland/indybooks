<template>
<buy-button v-if="isbn" :isbn="isbn" :productName="productName" />
</template>

<script lang="ts">
import Vue from 'vue';
import BuyButton from './BuyButton.vue';

export default Vue.extend({
  name: 'IndyBooks',
  components: { BuyButton },
  data() {
    return {
      isbn: '',
      productName: '',
    };
  },
  beforeMount() {
    const productDetails = document.getElementById('productDetailsTable');
    const productName = document.getElementById('productTitle');

    if (productName) {
      this.productName = productName.textContent || '';
    }

    if (productDetails) {
      const allChildren = productDetails.getElementsByTagName('*');

      Array.from(allChildren).forEach((item: any) => {
        if (item.textContent === 'ISBN-10:') {
          this.isbn = item.nextSibling.textContent;
        }
      });
    }
  },
});
</script>

<style>
</style>
