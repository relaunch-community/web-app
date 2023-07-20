import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="search-params"
export default class extends Controller {
  static targets = ["anchor"]

  connect() {
  }

  encode({target: {name, value}}) {
    for (const anchor of this.anchorTargets) {
      // https://developer.mozilla.org/en-US/docs/Web/API/HTMLAnchorElement
      anchor.search = new URLSearchParams({[name]: value})
    }
  }
}
