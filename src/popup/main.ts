import 'webextension-polyfill';
import Vue from 'vue';
import * as VueGoogleMaps from 'vue2-google-maps';
import Buefy from 'buefy';
import App from './App.vue';

/* eslint-disable no-new */
Vue.use(VueGoogleMaps, {
  load: {
    key: process.env.INDY_GOOGLE_MAPS_API_KEY,
    libraries: 'places',
  },
  installComponents: true,
});
Vue.use(Buefy);

new Vue({
  el: '#app',
  render: (h) => h(App),
});
