import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="collapse"
export default class extends Controller {
  static targets = ["description", "ingredients"]
  connect() {
    console.log("Hello")
  }

  showmore(e) {
    e.preventDefault;
    // this.descriptionTarget.classList.toggle("expandableCard")
    this.ingredientsTarget.classList.toggle("d-none")
  }
}
