import 'webextension-polyfill';
import Vue from 'vue';
import * as VueGoogleMaps from 'vue2-google-maps';
import Buefy from 'buefy';
import App from './App.vue';

/* eslint-disable no-new */
Vue.use(VueGoogleMaps, {
  load: {
    key: 'AIzaSyAZDGTSGj-7N7XyN8hmtCAS2C559xIUk9Q',
    libraries: 'places',
  },
  installComponents: true,
});
Vue.use(Buefy);

new Vue({
  el: '#app',
  render: (h) => h(App),
});
