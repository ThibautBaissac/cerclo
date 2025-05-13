import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "select", "input"]

  connect() {
    // Add data-filter-target attributes to form elements in the view
    this.selectTargets.forEach(select => {
      select.addEventListener("change", this.submit.bind(this))
    })

    this.inputTargets.forEach(input => {
      if (input.type === "date") {
        input.addEventListener("change", this.submit.bind(this))
      }
    })
  }

  submit() {
    // Delay slightly to allow for any other inputs to be changed
    setTimeout(() => {
      this.element.requestSubmit()
    }, 100)
  }
}