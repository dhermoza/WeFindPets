import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['button', 'filter'];

  connect() {
  }
  show(event) {
    event.preventDefault();
    this.filterTarget.classList.toggle("d-none");
  }
}
