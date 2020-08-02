<template>
<choose-bookstore />
</template>

<script lang="ts">
import Vue from 'vue';
import ChooseBookstore from './ChooseBookstore.vue';

export default Vue.extend({
  name: 'App',
  components: { ChooseBookstore },
});
</script>

<style lang="scss">
@import '@/scss/popover.scss';

html {
    width: 350px;
    height: 400px;
}
body {
    width: 350px;
    height: 400px;
    margin: 0;
}
</style>
