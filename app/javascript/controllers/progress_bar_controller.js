import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="progress-bar"
export default class extends Controller {
  static targets = ["progress"]
  static values = {
    duration: Number
  }

  connect() {
    console.log(this.durationValue); // converted to milliseconds (this.durationValue * 60 * 1000)
    this.countdown()
  }

  countdown() {
    const startTime = Date.now();
    setInterval(() => {
      const progressEl = document.getElementById("progress")
      const elapsedTime = Date.now() - startTime;
      let progress = (elapsedTime / 600000) * 100
      progressEl.style.width = `${progress}%`;
    }, 1000);

  }

}
