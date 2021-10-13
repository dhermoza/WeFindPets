import { Controller } from "stimulus";
import { initMapbox } from '../plugins/init_mapbox';

export default class extends Controller {
  static targets = ['map'];

  connect() {
    console.log(this.element);
    console.log(this.mapTarget);
    console.log("hola desde el controlador del show map")
    initMapbox();
  }
}
