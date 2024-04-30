import { Controller } from "@hotwired/stimulus";
import { Calendar } from "@fullcalendar/core";
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from "@fullcalendar/timegrid";
import listPlugin from "@fullcalendar/list";

export default class extends Controller {
  connect() {
    this.load();
  }

  load() {
    let calendar = new Calendar(this.element, {
      plugins: [dayGridPlugin, timeGridPlugin, listPlugin],
      initialView: "timeGridWeek",
      businessHours: {
        daysOfWeek: [ 1, 2, 3, 4, 5 ],
        startTime: '08:00', // a start time (10am in this example)
        endTime: '18:00', // an end time (6pm in this example)
      },
      headerToolbar: {
        left: "prev,next today",
        center: "title",
        right: "dayGridMonth,timeGridWeek,timeGridDay,listWeek",
      },
      eventClick: this.showModal,
      eventSources: [
        {
          events: this.loadAppointments,
        },
      ],
    });

    calendar.render();
  }

  showModal (info) {
    const appointmentModalElement =
      document.getElementById("appointment-modal");
    if (appointmentModalElement) {
      console.log("Event", info.event);
      document.getElementById("start-date-time").value =
        info.event.startStr.slice(0,16);
      document.getElementById("end-date-time").value =
        info.event.endStr.slice(0,16);
      document.getElementById("doctor-name").value =
        info.event.extendedProps.doctor.name;
      document.getElementById("specialty-name").value =
        info.event.extendedProps.specialty;
      document.getElementById("patient-name").value =
        info.event.extendedProps.patient.name;
      const appointmentModal = coreui.Modal.getOrCreateInstance(
        appointmentModalElement
      );
      appointmentModal.show();
    }
  }

  loadAppointments(info, successCallback, failureCallback) {
    const csrfToken = document
      .querySelector('meta[name="csrf-token"]')
      .getAttribute("content");

    fetch(
      `calendar?start_date=${info.start.toISOString()}&end_date=${info.end.toISOString()}`,
      {
        method: "GET",
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
          "X-CSRF-Token": csrfToken,
        },
      }
    )
      .then(async (res) => {
        let array = await res.json();
        successCallback(array);
      })
      .catch((error) => failureCallback(error));
  }
}
