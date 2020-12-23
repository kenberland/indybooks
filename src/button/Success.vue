<template>
  <section class="section">
    <div class="has-text-centered">
      <div class="is-size-1"> Thank You! </div>
      <br>
      <div class="is-size-4"> Your order {{purchaseInfo.orderID}} has been placed. </div>
      <br>
      <p>We sent an email to you with your purchase confirmation and invoice. If the email hasn't arrived please check your spam folder to see if the email was routed there.</p>
    </div>
  </section>
</template>

<script lang="ts">
import Vue from 'vue';

export default Vue.extend({
  name: 'Success',
  props: {
    purchaseInfo: Object,
  },
});
</script>

<style lang='scss' scoped>
@import '@/scss/indy-buttons.scss';
</style>
