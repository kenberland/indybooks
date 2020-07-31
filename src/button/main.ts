import Vue from 'vue';
import App from './App.vue';

/* eslint-disable no-new */

window.onload = () => {
  const newButton = document.createElement('div');
  newButton.setAttribute('id', 'indyButton');

  const buyNewInner = document.getElementById('buyNow_feature_div');
  if (buyNewInner !== undefined) {
    buyNewInner.insertAdjacentElement('afterend', newButton);
  }

  new Vue({
    el: '#indyButton',
    render: (h) => h(App),
  });
};
