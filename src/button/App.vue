<template>
  <buy-button />
</template>

<script lang="ts">
import Vue from 'vue';
import BuyButton from '@/components/BuyButton.vue';

export default Vue.extend({
  name: 'IndyBooks',
  components: { BuyButton },
});

</script>

<style>
html {
  width: 400px;
  height: 400px;
}
</style>
