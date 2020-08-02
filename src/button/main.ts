import 'webextension-polyfill';
import Vue from 'vue';
import Buefy from 'buefy';
import 'buefy/dist/buefy.css';
import App from './App.vue';

/* eslint-disable no-new */

window.onload = () => {
  const newButton = document.createElement('div');
  newButton.setAttribute('id', 'indyButton');

  const buyNewInner = document.getElementById('buyNow_feature_div');
  if (buyNewInner) {
    buyNewInner.insertAdjacentElement('afterend', newButton);
  }

  Vue.use(Buefy);

  new Vue({
    el: '#indyButton',
    render: (h) => h(App),
  });
};
