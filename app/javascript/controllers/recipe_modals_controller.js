import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="recipe-modals"
export default class extends Controller {
  static targets = ["modalbody"]
  connect() {
  }

  hello(event) {
    console.log(event.currentTarget.dataset["recipeId"])
    const recipeId = event.currentTarget.dataset["recipeId"]
    const url = `https://api.spoonacular.com/recipes/${recipeId}/information?apiKey=c4553cc010d340c5bfb18010d5180fa9`
    fetch(url)
     .then(response => response.json())
     .then((data) => {
        this.modalbodyTargets.forEach((target) => {this.insertData(data, target)})
     })
  }

  insertData(data, target) {
    target.innerHTML = "<p> Hi </p>";
  }
}
