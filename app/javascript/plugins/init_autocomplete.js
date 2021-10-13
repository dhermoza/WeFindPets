import places from 'places.js';
import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const initAutocomplete = () => {
  const addressInput = document.getElementById('post_address');
  const p = document.querySelector("p");
  const mapa = document.getElementById("map");
  if (addressInput) {
    places({ container: addressInput });
  }
  const preview = document.getElementById('preview');
  preview.addEventListener("click", (event)=> {
  const url = `https://api.mapbox.com/geocoding/v5/mapbox.places/${addressInput.value}.json?access_token=pk.eyJ1IjoiZGhlcm1vemEiLCJhIjoiY2t0b3FmNzFlMGZheDJvbnU0c3BmNWZkNiJ9.wkSimzYxZzc4KK951C0V0Q`;
  event.preventDefault();
  fetch(url).then(response => response.json())
  .then((data) => {
    const coord = data.features[0].center;
    const longitud = data.features[0].center[0];
    const latitud = data.features[0].center[1];
    const string = `${latitud}, ${longitud}`;
    p.innerText = "";
    p.insertAdjacentHTML("beforeend", string);
    mapboxgl.accessToken = 'pk.eyJ1IjoiZGhlcm1vemEiLCJhIjoiY2t0b3FmNzFlMGZheDJvbnU0c3BmNWZkNiJ9.wkSimzYxZzc4KK951C0V0Q';

    mapa.innerHTML = "";
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v9',
      center: coord,
      zoom: 15
    });
    new mapboxgl.Marker()
      .setLngLat(coord)
      .addTo(map);
  });
  })
};

export { initAutocomplete };
