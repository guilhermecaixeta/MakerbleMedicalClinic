import { Controller } from "@hotwired/stimulus";
import { FetchRequest } from "@rails/request.js";

export default class extends Controller {
  connect() {
    this.chartLoad();
  }

  async chartLoad() {
    Chart.defaults.pointHitDetectionRadius = 1;
    Chart.defaults.plugins.tooltip.enabled = false;
    Chart.defaults.plugins.tooltip.mode = "index";
    Chart.defaults.plugins.tooltip.position = "nearest";
    Chart.defaults.plugins.tooltip.external = coreui.ChartJS.customTooltips;
    Chart.defaults.defaultFontColor = coreui.Utils.getStyle("--cui-body-color");
    document.documentElement.addEventListener("ColorSchemeChange", () => {
      if (cardChart1) {
        cardChart1.data.datasets[0].pointBackgroundColor =
          coreui.Utils.getStyle("--cui-primary");
        cardChart1.update();
      }
      if (cardChart2) {
        cardChart2.data.datasets[0].pointBackgroundColor =
          coreui.Utils.getStyle("--cui-info");
        cardChart2.update();
      }
      if (mainChart) {
        mainChart.options.scales.x.grid.color = coreui.Utils.getStyle(
          "--cui-border-color-translucent"
        );
        mainChart.options.scales.x.ticks.color =
          coreui.Utils.getStyle("--cui-body-color");
        mainChart.options.scales.y.border.color = coreui.Utils.getStyle(
          "--cui-border-color-translucent"
        );
        mainChart.options.scales.y.grid.color = coreui.Utils.getStyle(
          "--cui-border-color-translucent"
        );
        mainChart.options.scales.y.ticks.color =
          coreui.Utils.getStyle("--cui-body-color");
        mainChart.update();
      }
    });

    const random = (min, max) =>
      Math.floor(Math.random() * (max - min + 1) + min);
    let request = new FetchRequest(
      "get",
      "/backoffice/statistics/weekly_for_patient.json",
      {
        contentType: "application/json",
        responseKind: "json",
      }
    );
    let response = await request.perform();
    let weekly_patient_statistics = await response.json;
    let total_patients_statistics =
      weekly_patient_statistics.statistics_per_day.map((wps) => wps.total);

    document.getElementById(
      "statistic-total-patients"
    ).innerHTML = `${weekly_patient_statistics.statistics_total} <span class="fs-6 fw-normal" id="statistic-total-patients-span"></span>`;
    document.getElementById("statistic-total-patients-span").innerHTML = `(${
      weekly_patient_statistics.growning
    }%
        <svg class="icon">
          <use xlink:href="${
            window.location.href
          }/app/assets/coreui/icons-2/sprites/free.svg#${
      weekly_patient_statistics.growning > 0
        ? "cil-arrow-top"
        : "cil-arrow-bottom"
    }"></use>
        </svg>)`;

    const cardChart1 = document.getElementById("card-chart1")
      ? new Chart(document.getElementById("card-chart1"), {
          type: "line",
          data: {
            labels: weekly_patient_statistics.statistics_per_day.map((wps) =>
              new Date(wps.date).toLocaleDateString(navigator.language, {
                weekday: "long",
              })
            ),
            datasets: [
              {
                label: "Weekly patients",
                backgroundColor: "transparent",
                borderColor: "rgba(255,255,255,.55)",
                pointBackgroundColor: coreui.Utils.getStyle("--cui-primary"),
                data: total_patients_statistics,
              },
            ],
          },
          options: {
            plugins: {
              legend: {
                display: false,
              },
            },
            maintainAspectRatio: false,
            scales: {
              x: {
                border: {
                  display: false,
                },
                grid: {
                  display: false,
                  drawBorder: false,
                },
                ticks: {
                  display: false,
                },
              },
              y: {
                min: 0,
                max: Math.ceil(total_patients_statistics.max / 10) * 10,
                display: false,
                grid: {
                  display: false,
                },
                ticks: {
                  display: false,
                },
              },
            },
            elements: {
              line: {
                borderWidth: 1,
                tension: 0.4,
              },
              point: {
                radius: 4,
                hitRadius: 10,
                hoverRadius: 4,
              },
            },
          },
        })
      : null;
    const cardChart2 = document.getElementById("card-chart2")
      ? new Chart(document.getElementById("card-chart2"), {
          type: "line",
          data: {
            labels: [
              "January",
              "February",
              "March",
              "April",
              "May",
              "June",
              "July",
            ],
            datasets: [
              {
                label: "My First dataset",
                backgroundColor: "transparent",
                borderColor: "rgba(255,255,255,.55)",
                pointBackgroundColor: coreui.Utils.getStyle("--cui-info"),
                data: [1, 18, 9, 17, 34, 22, 11],
              },
            ],
          },
          options: {
            plugins: {
              legend: {
                display: false,
              },
            },
            maintainAspectRatio: false,
            scales: {
              x: {
                border: {
                  display: false,
                },
                grid: {
                  display: false,
                  drawBorder: false,
                },
                ticks: {
                  display: false,
                },
              },
              y: {
                min: -9,
                max: 39,
                display: false,
                grid: {
                  display: false,
                },
                ticks: {
                  display: false,
                },
              },
            },
            elements: {
              line: {
                borderWidth: 1,
              },
              point: {
                radius: 4,
                hitRadius: 10,
                hoverRadius: 4,
              },
            },
          },
        })
      : null;

    // eslint-disable-next-line no-unused-vars
    const cardChart3 = document.getElementById("card-chart3")
      ? new Chart(document.getElementById("card-chart3"), {
          type: "line",
          data: {
            labels: [
              "January",
              "February",
              "March",
              "April",
              "May",
              "June",
              "July",
            ],
            datasets: [
              {
                label: "My First dataset",
                backgroundColor: "rgba(255,255,255,.2)",
                borderColor: "rgba(255,255,255,.55)",
                data: [78, 81, 80, 45, 34, 12, 40],
                fill: true,
              },
            ],
          },
          options: {
            plugins: {
              legend: {
                display: false,
              },
            },
            maintainAspectRatio: false,
            scales: {
              x: {
                display: false,
              },
              y: {
                display: false,
              },
            },
            elements: {
              line: {
                borderWidth: 2,
                tension: 0.4,
              },
              point: {
                radius: 0,
                hitRadius: 10,
                hoverRadius: 4,
              },
            },
          },
        })
      : null;

    // eslint-disable-next-line no-unused-vars
    const cardChart4 = document.getElementById("card-chart4")
      ? new Chart(document.getElementById("card-chart4"), {
          type: "bar",
          data: {
            labels: [
              "January",
              "February",
              "March",
              "April",
              "May",
              "June",
              "July",
              "August",
              "September",
              "October",
              "November",
              "December",
              "January",
              "February",
              "March",
              "April",
            ],
            datasets: [
              {
                label: "My First dataset",
                backgroundColor: "rgba(255,255,255,.2)",
                borderColor: "rgba(255,255,255,.55)",
                data: [
                  78, 81, 80, 45, 34, 12, 40, 85, 65, 23, 12, 98, 34, 84, 67,
                  82,
                ],
                barPercentage: 0.6,
              },
            ],
          },
          options: {
            maintainAspectRatio: false,
            plugins: {
              legend: {
                display: false,
              },
            },
            scales: {
              x: {
                grid: {
                  display: false,
                  drawTicks: false,
                },
                ticks: {
                  display: false,
                },
              },
              y: {
                border: {
                  display: false,
                },
                grid: {
                  display: false,
                  drawBorder: false,
                  drawTicks: false,
                },
                ticks: {
                  display: false,
                },
              },
            },
          },
        })
      : null;
    const mainChart = document.getElementById("main-chart")
      ? new Chart(document.getElementById("main-chart"), {
          type: "line",
          data: {
            labels: [
              "January",
              "February",
              "March",
              "April",
              "May",
              "June",
              "July",
            ],
            datasets: [
              {
                label: "My First dataset",
                backgroundColor: `rgba(${coreui.Utils.getStyle(
                  "--cui-info-rgb"
                )}, .1)`,
                borderColor: coreui.Utils.getStyle("--cui-info"),
                pointHoverBackgroundColor: "#fff",
                borderWidth: 2,
                data: [
                  random(50, 200),
                  random(50, 200),
                  random(50, 200),
                  random(50, 200),
                  random(50, 200),
                  random(50, 200),
                  random(50, 200),
                ],
                fill: true,
              },
              {
                label: "My Second dataset",
                borderColor: coreui.Utils.getStyle("--cui-success"),
                pointHoverBackgroundColor: "#fff",
                borderWidth: 2,
                data: [
                  random(50, 200),
                  random(50, 200),
                  random(50, 200),
                  random(50, 200),
                  random(50, 200),
                  random(50, 200),
                  random(50, 200),
                ],
              },
            ],
          },
          options: {
            maintainAspectRatio: false,
            plugins: {
              annotation: {
                annotations: {
                  line1: {
                    type: "line",
                    yMin: 95,
                    yMax: 95,
                    borderColor: coreui.Utils.getStyle("--cui-danger"),
                    borderWidth: 1,
                    borderDash: [8, 5],
                  },
                },
              },
              legend: {
                display: false,
              },
            },
            scales: {
              x: {
                grid: {
                  color: coreui.Utils.getStyle(
                    "--cui-border-color-translucent"
                  ),
                  drawOnChartArea: false,
                },
                ticks: {
                  color: coreui.Utils.getStyle("--cui-body-color"),
                },
              },
              y: {
                border: {
                  color: coreui.Utils.getStyle(
                    "--cui-border-color-translucent"
                  ),
                },
                grid: {
                  color: coreui.Utils.getStyle(
                    "--cui-border-color-translucent"
                  ),
                },
                ticks: {
                  beginAtZero: true,
                  color: coreui.Utils.getStyle("--cui-body-color"),
                  max: 250,
                  maxTicksLimit: 5,
                  stepSize: Math.ceil(250 / 5),
                },
              },
            },
            elements: {
              line: {
                tension: 0.4,
              },
              point: {
                radius: 0,
                hitRadius: 10,
                hoverRadius: 4,
                hoverBorderWidth: 3,
              },
            },
          },
        })
      : null;
  }
}
