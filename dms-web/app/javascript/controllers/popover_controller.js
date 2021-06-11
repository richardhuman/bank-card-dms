/* eslint-disable no-undef */
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "popoverContainer" ];

  toggle(event) {
    event.preventDefault();
    if (this.popoverContainerTarget.classList.contains("open")) {
      this.popoverContainerTarget.classList.remove("open");
    } else {
      this.popoverContainerTarget.classList.add("open");
    }
  }
}
