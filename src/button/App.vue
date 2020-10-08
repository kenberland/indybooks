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
    const productDetails = document.getElementById('detailBullets_feature_div');
    const productName = document.getElementById('productTitle');

    if (productName) {
      this.productName = productName.textContent || '';
    }

    if (productDetails) {
      const isbnIndex = productDetails.innerText.search('ISBN-13');
      const remainingDetails = productDetails.innerText.slice(isbnIndex + 10);
      if (remainingDetails) {
        const numberEnders = remainingDetails.match(/\d*-\d*$/gm);
        if (numberEnders) {
          // eslint-disable-next-line
          this.isbn = numberEnders[0];

          if (this.isbn === '') {
            // eslint-disable-next-line
            console.log('ISBN not found');
          } else {
            // eslint-disable-next-line
            this.isbn = this.isbn.replace('-','');
            console.log(`ISBN found: ${this.isbn}`);
          }
        }
      }
    }
  },
});
</script>

<style>
</style>
