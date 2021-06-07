/* eslint-disable no-undef */
import { Controller } from "stimulus";

export default class Navbar extends Controller {
  connect() {
    document.querySelectorAll("a[data-popover]").forEach((popoverTrigger) => {
      popoverTrigger.addEventListener("click", (evt) => {
        evt.stopImmediatePropagation();
        this.togglePopover(popoverTrigger);
      });
    });
  }

  // eslint-disable-next-line class-methods-use-this
  togglePopover(popoverElement) {
    const popoverId = popoverElement.dataset.popover;
    const popover = document.querySelector(`#${popoverId}`);
    if (popover.classList.contains("open")) {
      popover.classList.remove("open");
    } else {
      popover.classList.add("open");
    }
  }
}
