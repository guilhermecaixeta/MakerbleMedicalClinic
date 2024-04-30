import { Controller } from "@hotwired/stimulus";
import { post } from "@rails/request.js";

export default class extends Controller {
  static values = { doctorid: Number };

  connect() {
    this.update_doctors();
  }

  update_doctors() {
    const specialty_id = this.element.value;
    const selected_doctor_id = this.doctoridValue;

    if (specialty_id <= 0) return;

    post("/backoffice/doctors/filter_by_specialty/", {
      query: {
        specialty_id: specialty_id,
        selected_doctor_id: selected_doctor_id,
      },
      responseKind: "turbo-stream",
    });
  }
}
