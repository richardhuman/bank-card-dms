/* eslint-disable class-methods-use-this */
import { Controller } from "stimulus";

export default class extends Controller {
  // eslint-disable-next-line class-methods-use-this
  connect() {
    this.startClose();
  }

  startClose() {
    setTimeout(() => {
      const notice = document.querySelector("#notice");
      if (notice !== null) {
        notice.classList.add("fade-out");
      }
    }, 5000);
  }
}
