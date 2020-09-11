<template>
<div class='choose-bookstore'>
  <div class='columns is-mobile'>
    <div class='column no-padding is-9'>
      <GmapMap
        ref="mapRef"
        :center="{lat:center.lat, lng:center.long}"
        :zoom="13"
        style="width: 100%; height: 500px"
        >
        <GmapMarker
          v-for="(store, index) in stores"
          :key="index"
          :position="{lat:store.lat, lng:store.long}"
          :clickable="true"
          :title="store.name"
          :label="store.name"
          @click="centerOnPin"
          />
      </GmapMap>
    </div>
    <div class='column no-padding is-3'>
      <a class='panel-block'
         v-for="store in stores"
         :key="store.lat"
         v-on:click="centerOnStore(store)">
        <store :store="store" />
      </a>
    </div>
  </div>
</div>
</template>

<script lang="ts">
import Vue from 'vue';
import axios from 'axios';
import Store from './Store.vue';

export default Vue.extend({
  name: 'App',
  components: { Store },
  data() {
    const stores:any[] = [];
    const center = { lat: null, long: null };
    const myMap = null;
    return {
      stores,
      center,
      myMap,
    };
  },
  methods: {
    centerOnStore(store: any): void {
      // eslint-disable-next-line max-len
      (this.$refs.mapRef as GoogleObject).$mapObject.panTo({ lat: store.lat, lng: store.long });
      // this.$refs.mapRef.$mapObject.panTo({ lat: store.lat, lng: store.long });
    },

    centerOnPin(pin: any): void {
      (this.$refs.mapRef as GoogleObject).$mapObject.panTo({ lat: pin.latLng.lat(), lng: pin.latLng.lng() });
    },

    geoSuccess(position: any): void {
      this.center.lat = position.coords.latitude;
      this.center.long = position.coords.longitude;
    },

    geoError(error: any): void {
      // eslint-disable-next-line
      console.log(error);
    },

    getIndybooksPlacesAsync(map: any): void {
      const lat = map.getCenter().lat();
      const lng = map.getCenter().lng();

      axios
        .get(`https://api.indybooks.net/v5/stores/lat/${lat}/long/${lng}`)
        .then((response) => {
          response.data.stores.forEach((item: any) => {
            let foundStore = false;

            this.stores.forEach((store: any) => {
              if (store.lat === item.lat && store.long === item.long) {
                foundStore = true;
              }
            });

            if (!foundStore) {
              this.stores.push(item);
            }
          });
        })
        .catch((error) => {
          // eslint-disable-next-line
          console.log(error);
        });
    },
  },
  beforeMount() {
    if (!navigator.geolocation) {
      // eslint-disable-next-line
      console.log('Location unavailible, can not get location');
    } else {
      navigator.geolocation.getCurrentPosition(this.geoSuccess, this.geoError);
    }
    browser.storage.sync.get(['indystores']).then((obj: any) => {
      if (obj.indystores !== undefined) {
        obj.indystores.stores.forEach((item: any) => {
          this.stores.push(item);
        });
      }
    });
  },
  mounted() {
    // I give up, I need a fucking Typescript engineer with 5 years experience
    // to tell me wtf is wrong here.
    // I don't know enough to be able to typecast any of this shit.
    (this.$refs.mapRef as GoogleObject).$mapPromise.then((map: any) => {
      this.myMap = map;
      map.addListener('bounds_changed', () => {
        setTimeout(this.getIndybooksPlacesAsync, 100, this.myMap);
      });
    });
  },
});
</script>

<style lang="scss">
.choose-bookstore {
    .columns {
        width: 100%;
        margin: 0;

        .no-padding {
            padding: 0;

            .store-details {
                padding: 0;
            }

            .store-switch {
                padding: 0 0 0 15px;
            }
        }
    }
    .panel-block:first-child {
        border-top: none;
    }
    .columns:last-child {
        margin: 0;
    }
}
</style>
