<template>
<div class='container'>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
  <nav class='panel'>
    <div class='panel-heading'>
      <!-- eslint-disable-next-line max-len -->
      <the-mask id='search' class='search-input' :mask="'#####'"  placeholder='Search' v-model.number="zip" />
      <b-button class="my-stores"
                icon-pack="fas"
                icon-right="store-alt"
                v-on:click="swapStoreView">
        {{buttonName}}
      </b-button>
    </div>
    <transition name="component-fade" mode="out-in">
      <component v-bind:is="bookstores"></component>
    </transition>
  </nav>
</div>
</template>

<script lang="ts">
import Vue from 'vue';
import { TheMask } from 'vue-the-mask';
import ChooseBookstore from './ChooseBookstore.vue';
import MyBookstores from './MyBookstores.vue';

export default Vue.extend({
  name: 'App',
  components: { ChooseBookstore, MyBookstores, TheMask },
  data() {
    const currentTab = 'ChooseBookstore';
    const buttonName = 'My Stores';
    return {
      zip: '',
      currentTab,
      buttonName,
      tabs: ['ChooseBookstore', 'MyBookstores'],
    };
  },
  methods: {
    swapStoreView(): void {
      if (this.currentTab === 'ChooseBookstore') {
        this.currentTab = 'MyBookstores';
        this.buttonName = 'Find Stores';
      } else {
        this.currentTab = 'ChooseBookstore';
        this.buttonName = 'My Stores';
      }
    },
  },
  computed: {
    bookstores(): string {
      return this.currentTab;
    },
  },
});
</script>

<style lang="scss">
@import '@/scss/popover.scss';

html {
    width: 800px;
    height: 550px;
}
body {
    width: 800px;
    height: 550px;
    margin: 0;
}

.search-input {
    background-color: transparent;
    border: none;
    outline: none;
    font-size: normal;
    background-image: url("../assets/images/Search.png");
    background-repeat: no-repeat;
    background-size: 17px;
    padding-left: 40px;
}

.panel-heading {
    .my-stores {
        float: right;
        background-color: transparent;
        border-color: transparent;
        padding-bottom: 15px;
        &:hover {
            border-color: transparent;
        }
        &:focus {
            box-shadow: none;
            border-color: transparent;
            &:not(:active) {
                box-shadow: none;
            }
        }
    }
}

.panel-heading {
    height: 50px;
}

.component-fade-enter-active, .component-fade-leave-active {
  transition: opacity .3s ease;
}

.component-fade-enter, .component-fade-leave-to {
  opacity: 0;
}
</style>
