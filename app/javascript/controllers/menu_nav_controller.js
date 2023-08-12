import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="menu-nav"
export default class extends Controller {
  static targets = ["button", "menu"]

  connect() {
  }

  toggle() {
    if (this.hasButtonTarget) {
      this.buttonTarget.classList.toggle('open')
    }

    if (this.hasMenuTarget) {
      this.menuTarget.classList.toggle('flex')
      this.menuTarget.classList.toggle('hidden')
    }
  }
}
