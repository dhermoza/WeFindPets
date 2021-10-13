import { Controller } from "stimulus";
import { initMapbox } from '../plugins/init_mapbox';

export default class extends Controller {
  static targets = ['map', 'out', 'preview', 'inputAddress'];

  connect() {
    console.log(this.element);
    console.log(this.mapTarget);
    console.log(this.outTarget);
    console.log(this.previewTarget);
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(this.showPosition.bind(this));
    } else {
      this.outTarget.innerHTML = "Geolocation is not supported by this browser.";
    }
  }
  showPosition(position) {
  const latitude = position.coords.latitude;
  const longitude = position.coords.longitude;
  const coord = {}
  coord.lat = latitude;
  coord.lng = longitude;
  const coordenadas = JSON.stringify(coord);
  console.log(position.coords.latitude);
  console.log(position.coords.longitude);
  this.mapTarget.setAttribute('data-marker', coordenadas);
  initMapbox();
  }
  showMap(event) {
    event.preventDefault();
    console.log("me clickearon tengo que agregar el mapa")
    const url = `https://api.mapbox.com/geocoding/v5/mapbox.places/${this.inputAddressTarget.value}.json?access_token=pk.eyJ1IjoiZGhlcm1vemEiLCJhIjoiY2t0b3FmNzFlMGZheDJvbnU0c3BmNWZkNiJ9.wkSimzYxZzc4KK951C0V0Q`;
    fetch(url).then(response => response.json())
    .then((data) => {
      const coordenadas = data.features[0].center;
      const coord = {}
      coord.lat = coordenadas[1];
      coord.lng = coordenadas[0];
      console.log(JSON.stringify(coord))
      this.mapTarget.setAttribute('data-marker', JSON.stringify(coord));
      initMapbox();
    });
  };

}
