import { Controller } from "stimulus";
export default class extends Controller {
  static targets = ['input','posts', 'button', 'form'];

  connect() {
    console.log(this.inputTarget);
    console.log(this.postsTarget);
    console.log(this.buttonTarget);
    console.log(this.formTarget);
  }
  search(event) {
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => {
        this.listTarget.outerHTML = data;
      })
  }
}
