export class Navbar {

  init() {
    document.querySelectorAll("a[data-popover]").forEach((popoverTrigger) => {
      popoverTrigger.addEventListener("click", (evt) => {
        evt.stopImmediatePropagation();
        this.togglePopover(popoverTrigger);
      });
    });
  }

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
