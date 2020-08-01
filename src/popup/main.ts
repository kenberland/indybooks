import Vue from 'vue';
import Buefy from 'buefy';
import 'buefy/dist/buefy.css';
import App from './App.vue';

/* eslint-disable no-new */

Vue.use(Buefy);

new Vue({
  el: '#app',
  render: (h) => h(App),
});
