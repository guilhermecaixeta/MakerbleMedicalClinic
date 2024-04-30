import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  toggle() {
    coreui.Sidebar.getOrCreateInstance(
      document.querySelector("#sidebar")
    ).toggle();
  }
}
