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
      headerToolbar: {
        left: "prev,next today",
        center: "title",
        right: "dayGridMonth,timeGridWeek,timeGridDay,listWeek",
      },
      eventClick: function (info) {
        const appointmentModalElement =
          document.getElementById("appointment-modal");
        if (appointmentModalElement) {
          document.getElementById("start-date-time").value =
            info.event.extendedProps.doctor.name;
          document.getElementById("end-date-time").value =
            info.event.extendedProps.doctor.name;
          document.getElementById("doctor-name").value =
            info.event.extendedProps.doctor.name;
          document.getElementById("specialty-name").value =
            info.event.extendedProps.doctor.specialty;
          document.getElementById("patient-name").value =
            info.event.extendedProps.doctor.name;
          const appointmentModal = coreui.Modal.getOrCreateInstance(
            appointmentModalElement
          );
          appointmentModal.show();
        }
      },
      events: [
        {
          id: 1,
          title: "Doc - General",
          extendedProps: { doctor: { name: "Doc", specialty: "General" } },
          start: "2024-04-26T20:00:00",
          end: "2024-04-27T08:00:00",
        },
        {
          id: 2,
          title: "Doc - General",
          extendedProps: { doctor: { name: "Doc", specialty: "General" } },
          start: "2024-04-26T07:00:00",
          end: "2024-04-26T08:00:00",
        },
      ],
    });
    calendar.render();
  }
}
