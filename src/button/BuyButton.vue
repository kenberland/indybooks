<template>
<div>
  <transition name='modal'>
    <div v-if="isOpen">
      <div class='overlay' @click.self="isOpen = false;">
        <buy-modal :isbn="isbn" :stores="localStores" :productName="productName" />
      </div>
    </div>
  </transition>
  <div v-if="anyStores" id='indyRef' @click="loadModal">
    <div id='indy' class='indy-button'>
      <div id='indyText' class='indy-text'>
        Buy Local
      </div>
    </div>
  </div>
</div>
</template>

<script lang="ts">
import Vue from 'vue';
import axios from 'axios';
import BuyModal from './BuyModal.vue';

// localStores is going to be loaded via an endpoint soon.  Right now it's a static array.
export default Vue.extend({
  name: 'BuyButton',
  components: { BuyModal },
  props: {
    isbn: String,
    productName: String,
  },
  data() {
    // eslint-disable-next-line
    const localStores: any[] = [];
    return {
      isOpen: false,
      localStores,
    };
  },
  computed: {
    anyStores: function() {
      return this.localStores.length > 0;
    }
  },
  beforeMount() {
    // eslint-disable-next-line
    var stores = [] as any[];
    this.localStores = [];
    // eslint-disable-next-line
    browser.storage.sync.get(['indystores']).then((obj: any) => {
      if (obj.indystores !== undefined) {
        stores = obj.indystores.stores;

        axios
          .get(`https://api.indybooks.net/v5/offers/isbn/${this.isbn}/vendors/${stores.map(this.getUuid).join()}`)
          .then((response) => {
            // eslint-disable-next-line
            response.data.offers.forEach((item: any) => {
              // eslint-disable-next-line
              const foundIndex = stores.findIndex((store: any) => store.uuid === item.vendor_uuid);
              const newStore = stores[foundIndex];
              newStore.promise = item;

              this.localStores.push(newStore);
            });
          })
          .catch((error) => {
            // eslint-disable-next-line
            console.log(error);
          });
      }
    });
  },
  methods: {
    loadModal(): void {
      this.isOpen = !this.isOpen;
    },
    // eslint-disable-next-line
    getUuid(store: any): string {
      return store.uuid;
    },
  },
});
</script>

<style lang='scss' scoped>
@import '@/scss/indy-buttons.scss';
.modal {
  width: 500px;
  margin: 0px auto;
  padding: 20px;
  background-color: #fff;
  border-radius: 2px;
  box-shadow: 0 2px 8px 3px;
  transition: all 0.2s ease-in;
  font-family: Helvetica, Arial, sans-serif;
}

.fadeIn-enter {
  opacity: 0;
}

.fadeIn-leave-active {
  opacity: 0;
  transition: all 0.2s step-end;
}

.fadeIn-enter .modal,

.fadeIn-leave-active.modal {
  transform: scale(1.1);
}

.overlay {
  position: fixed;
  top: 0;
  left: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  background: #00000094;
  z-index: 999;
  transition: opacity 0.2s ease;
}

#indyReceiptContent {
  z-index: 501;
  opacity: 1.0;
  position: absolute;
  width: 70%;
  height: 50%;
  top: 25%;
  left: 15%;
  background-color: white;
  border: 1px black solid;
  text-align: center;
  display: block;
  vertical-align: middle;
}

#indyWhitePane {
  width: 100%;
  height: 100%;
  z-index: 500;
  display: block;
  position: absolute;
  background: white;
  opacity: 0.5;
}
</style>
