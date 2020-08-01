<template>
<div class='store-list'>
  <div class='store'>
    <div class='store-name'>
      <h4>{{ store.name }}</h4>
    </div>
    <div class='store-address'>
      {{ store.address }}
    </div>
    <div class='select-store'>

    </div>
</div>
</div>
</template>

<script lang="ts">
import Vue from 'vue';

export default Vue.extend({
  name: 'Store',
  props: {
    store: Object,
  },
});
</script>

<style lang="scss">
.store-list {
}
.store {
    border-bottom: 1px solid #e7e7e7;
    height: 45px;
    padding: 15px 18px;
    &:hover {
        background-color: #f5f5f5;
    }
}
.store-name {
    margin-top: 5px;
    h4 {
        margin: 0;
    }
}
</style>
