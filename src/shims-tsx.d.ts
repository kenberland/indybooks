import Vue, { VNode } from 'vue';

declare global {
  namespace JSX {
    // tslint:disable no-empty-interface
    interface Element extends VNode {}
    // tslint:disable no-empty-interface
    interface ElementClass extends Vue {}
    interface IntrinsicElements {
      [elem: string]: any;
    }
  }

  interface GoogleMapp extends Object {
    panTo(latlong: any): void;
    then(anonfunction: any): void;
  }

  interface GoogleObject extends Vue {
    $mapObject: GoogleMapp;
    $mapPromise: GoogleMapp;
  }
}
