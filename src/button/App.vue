<template>
<buy-button v-if="isbn" :isbn="isbn" :productName="productName" :buyAgain="buyAgain" />
</template>

<script lang="ts">
import Vue from 'vue';
import { v4 as uuidv4 } from 'uuid';
import axios from 'axios';
import BuyButton from './BuyButton.vue';

export default Vue.extend({
  name: 'IndyBooks',
  components: { BuyButton },
  data() {
    return {
      isbn: '',
      productName: '',
      buyAgain: false
    };
  },
  beforeMount() {
    const productDetails = document.getElementById('detailBullets_feature_div');
    const productName = document.getElementById('productTitle');
    let customerUuid = null;

    browser.storage.sync.get(['indybuyUuid']).then((obj: any) => {
      customerUuid = obj.indybuyUuid;
      if (customerUuid === null) {
        browser.storage.sync.set({ indybuyUuid: uuidv4() });
      }

      axios.get(`https://api.indybooks.net/v5/purchases/customer_uuid/${customerUuid}`)
        .then((response) => {
          if (productName) {
            this.productName = productName.textContent || '';
          }

          if (productDetails) {
            const isbnIndex = productDetails.innerText.search('ISBN-10');
            const remainingDetails = productDetails.innerText.slice(isbnIndex + 10);
            if (remainingDetails) {
              const numberEnders = remainingDetails.match(/\d*$/gm);
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
          const purchased = response.data.purchases.some(purchase => {
            return purchase.isbn === this.isbn
          });

          this.buyAgain = purchased;
        });
    });
  },
});
</script>

<style>
</style>
