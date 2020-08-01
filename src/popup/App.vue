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

<style>
html {
  width: 350px;
  height: 400px;
}
body {
    margin: 0;
}
</style>
