import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dynamic-select"
export default class extends Controller {
  static targets = [ "selectClick" ]

  connect() {
  }

  selectClick() {
    this.selectClickTargets.forEach(target => target.click())
  }
}
