<template>
<div class='store columns is-mobile'>
  <div class='column is-4 is-offset-1'>
    <div class='store-name'>
      <h4>{{ store.name }}</h4>
    </div>
    <div class='store-address'>
      {{ store.address }}
    </div>
  </div>
  <div class='column is-2'>
    <div class='store-price'>
      <h4>${{ store.promise.price }}</h4>
      <h4>({{ store.promise.delivery_promise }})</h4>
    </div>
  </div>
  <div class='column is-3 is-offset-2'>
    <div id="paypal-button-container"></div>
  </div>
</div>
</template>

<script lang="ts">
import paypal from 'paypal-checkout';
import Vue from 'vue';

export default Vue.extend({
  name: 'Store',
  props: {
    store: Object,
  },
  mounted() {
    paypal.Button.render({
      env: 'sandbox',
      style: {
        label: 'paypal',
        size: 'responsive',
        shape: 'rect',
      },
      client: {
        sandbox: 'AZzahVK6f1JiZtq7J_jBNIC6ZIyzE9Fi9Pp9ITMnhL6lgeLaJRVxJUsStutj_xDlPecZxH0W7nWCaynU',
        production: 'sb',
      },
      // eslint-disable-next-line
      payment: (data: any, actions: any) => (
        actions.payment.create({
          payment: {
            transactions: [
              {
                amount: { total: this.store.promise.price, currency: 'USD' },
              },
            ],
          },
        })
      ),
      // eslint-disable-next-line
      onAuthorize: (data: any, options: any) => {
        const purchaseData = {
          paypalData: data,
          storeData: this.store,
        };
        this.$emit('successfulPurchase', purchaseData);
        // eslint-disable-next-line
        console.log('authorized');
        // eslint-disable-next-line
        console.log(data);
        // eslint-disable-next-line
        console.log(options);
      },
      // eslint-disable-next-line
      onCancel: (data: any) => {
        // eslint-disable-next-line
        console.log(data);
        // eslint-disable-next-line
        console.log('Payment Cancelled');
      },
      // eslint-disable-next-line
      onError: (err: any) => {
        // eslint-disable-next-line
        console.error(err);
      },
    }, '#paypal-button-container');
  },
});
</script>

<style lang='scss' scoped>
@import '@/scss/indy-buttons.scss';
.store {
    width: 100%;
}
</style>
