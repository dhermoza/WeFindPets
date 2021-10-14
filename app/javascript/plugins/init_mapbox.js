import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const marker = JSON.parse(mapElement.dataset.marker);
    const coord = [marker.lng, marker.lat]
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10',
      center: coord,
      zoom: 15
    })
    new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        .addTo(map);
  }
};

export { initMapbox };
