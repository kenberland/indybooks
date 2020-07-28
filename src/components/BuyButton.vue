<template>
  <div>
    <transition name="modal">
      <div v-if="isOpen">
        <div class="overlay" @click.self="isOpen = false;">
          <buy-modal />
        </div>
      </div>
    </transition>
    <div id='indyRef' href='foo.com' @click="isOpen = !isOpen;">
      <div id='indy'>
        <div id='indyText'>
          Buy at Ms. Dalloway's
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from 'vue';
import BuyModal from '@/components/BuyModal.vue';

export default Vue.extend({
  name: 'BuyButton',
  components: { BuyModal },
  data() {
    return {
      isOpen: false,
    };
  },
});
</script>

<style scoped>
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
#indy {
  height: 3em;
  display: block;
  margin-left: 0;
  vertical-align: middle;
  text-align: center;
  border-color: #a88734 #9c7e31 #846a29;
  color: #111;
  display: block;
  position: relative;
  overflow: hidden;
  box-shadow: 0 1px 0 rgba(255,255,255,.6) inset;
  border-radius: 2px;
  background: linear-gradient(to bottom,#f6c88f,#ed9220);
  cursor: pointer;
}
#indy:hover {
  background: linear-gradient(to bottom,#f6c88f,#d47d11);
}

#indyText {
  line-height: 3em;
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
