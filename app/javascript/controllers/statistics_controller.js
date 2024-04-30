import { Controller } from "@hotwired/stimulus";
import { FetchRequest } from "@rails/request.js";

export default class extends Controller {
  static targets = ["monthlyChart"];
  monthtlyChart;
  weeklyPatientChart;
  weeklyAppointmentChart;

  connect() {
    this.chartsDefault();
    this.loadMonthlyChart();
    this.loadWeeklyGrownPatientChart();
    this.loadWeeklyGrownAppointmentChart();
  }

  disconnect() {
    this.monthtlyChart?.destroy();
    this.weeklyPatientChart?.destroy();
    this.weeklyAppointmentChart?.destroy();
  }

  chartsDefault() {
    Chart.defaults.pointHitDetectionRadius = 1;
    Chart.defaults.plugins.tooltip.enabled = false;
    Chart.defaults.plugins.tooltip.mode = "index";
    Chart.defaults.plugins.tooltip.position = "nearest";
    Chart.defaults.plugins.tooltip.external = coreui.ChartJS.customTooltips;
    Chart.defaults.defaultFontColor = coreui.Utils.getStyle("--cui-body-color");
  }

  async loadWeeklyGrownPatientChart() {
    let weeklyStatistics = await this.loadStatisticData(
      "weekly_grown_for_patient"
    );

    let total = weeklyStatistics.statistics_per_day.map((wps) => wps.total);

    this.setStatisticsElements(
      "weekly-statistic-patients",
      weeklyStatistics.statistics_total,
      weeklyStatistics.growning_rate
    );

    if (!this.weeklyPatientChart && !Chart.getChart("weekly-statistic-patients-chart")) {
      this.weeklyPatientChart = new Chart(
        document.getElementById("weekly-statistic-patients-chart"),
        {
          id: 3,
          type: "line",
          data: {
            labels: weeklyStatistics.statistics_per_day.map((wps) =>
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
                data: total,
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
                max: this.roundUpValue(total),
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
        }
      );
    }
    this.setChartStyle(this.weeklyPatientChart, "--cui-primary");
  }

  async loadWeeklyGrownAppointmentChart() {
    let weeklyStatistics = await this.loadStatisticData(
      "weekly_grown_for_appointment"
    );

    let total = weeklyStatistics.statistics_per_day.map((wps) => wps.total);
    this.setStatisticsElements(
      "weekly-statistic-appointments",
      weeklyStatistics.statistics_total,
      weeklyStatistics.growning_rate
    );

    if (!this.weeklyAppointmentChart && !Chart.getChart("weekly-statistic-appointments-chart")) {
      this.weeklyAppointmentChart = new Chart(
        document.getElementById("weekly-statistic-appointments-chart"),
        {
          id: 2,
          type: "line",
          data: {
            labels: weeklyStatistics.statistics_per_day.map((wps) =>
              new Date(wps.date).toLocaleDateString(navigator.language, {
                weekday: "long",
              })
            ),
            datasets: [
              {
                label: "Weekly appointments",
                backgroundColor: "transparent",
                borderColor: "rgba(255,255,255,.55)",
                pointBackgroundColor: coreui.Utils.getStyle("--cui-info"),
                data: total,
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
                max: this.roundUpValue(total),
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
        }
      );
    }
    this.setChartStyle(this.weeklyAppointmentChart, "--cui-info");
  }

  async loadMonthlyChart() {
    let monthlyStatistics = await this.loadStatisticData(
      "monthly_relation_appointments_patients"
    );

    document.getElementById("patients-total-month").innerHTML =
      monthlyStatistics.total_patients;
    document.getElementById("appointments-total-month").innerHTML =
      monthlyStatistics.total_appointments;
    document.getElementById("secondary-text").innerHTML = `${new Date(
      monthlyStatistics.started_at.slice(0, 16)
    ).toLocaleString("default", {
      month: "long",
    })} - ${new Date(monthlyStatistics.ended_at.slice(0, 16)).toLocaleString(
      "default",
      {
        month: "long",
      }
    )}`;

    if (!this.monthtlyChart && !Chart.getChart("monthly-chart")) {
      this.monthtlyChart = new Chart(document.getElementById("monthly-chart"), {
        id: 1,
        type: "line",
        data: {
          labels: monthlyStatistics.monthly_statistics.map((ms) => ms.day),
          datasets: [
            {
              label: "Patients",
              backgroundColor: `rgba(${coreui.Utils.getStyle(
                "--cui-info-rgb"
              )}, .1)`,
              borderColor: coreui.Utils.getStyle("--cui-info"),
              pointHoverBackgroundColor: "#fff",
              borderWidth: 2,
              data: monthlyStatistics.monthly_statistics.map(
                (ms) => ms.total_patients
              ),
              fill: true,
            },
            {
              label: "Appointments",
              borderColor: coreui.Utils.getStyle("--cui-success"),
              pointHoverBackgroundColor: "#fff",
              borderWidth: 2,
              data: monthlyStatistics.monthly_statistics.map(
                (ms) => ms.total_appointments
              ),
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
                  yMin: 0,
                  yMax: 100,
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
                color: coreui.Utils.getStyle("--cui-border-color-translucent"),
                drawOnChartArea: false,
              },
              ticks: {
                color: coreui.Utils.getStyle("--cui-body-color"),
              },
            },
            y: {
              border: {
                color: coreui.Utils.getStyle("--cui-border-color-translucent"),
              },
              grid: {
                color: coreui.Utils.getStyle("--cui-border-color-translucent"),
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
              hitRadius: 30,
              hoverRadius: 4,
              hoverBorderWidth: 3,
            },
          },
        },
      });
    }
    document.documentElement.addEventListener("ColorSchemeChange", () => {
      this.monthtlyChart.options.scales.x.grid.color = coreui.Utils.getStyle(
        "--cui-border-color-translucent"
      );
      this.monthtlyChart.options.scales.x.ticks.color =
        coreui.Utils.getStyle("--cui-body-color");
      chart.options.scales.y.border.color = coreui.Utils.getStyle(
        "--cui-border-color-translucent"
      );
      this.monthtlyChart.options.scales.y.grid.color = coreui.Utils.getStyle(
        "--cui-border-color-translucent"
      );
      this.monthtlyChart.options.scales.y.ticks.color =
        coreui.Utils.getStyle("--cui-body-color");
      this.monthtlyChart.update();
    });
  }

  roundUpValue(value) {
    return Math.ceil(value.max / 10) * 10;
  }

  setChartStyle(chart, style) {
    document.documentElement.addEventListener("ColorSchemeChange", () => {
      if (chart) {
        chart.data.datasets[0].pointBackgroundColor =
          chart.Utils.getStyle(style);
        chart.update();
      }
    });
  }

  setStatisticsElements(elementId, statisticsTotal, growningRate) {
    document.getElementById(
      elementId
    ).innerHTML = `${statisticsTotal} <span class="fs-6 fw-normal" id="${elementId}-span">
    (${growningRate}%
        <svg class="icon">
          <use xlink:href="${
            window.location.href
          }/app/assets/coreui/icons-2/sprites/free.svg#${
      growningRate > 0 ? "cil-arrow-top" : "cil-arrow-bottom"
    }"></use>
        </svg>)
    </span>`;
  }

  async loadStatisticData(action) {
    let request = new FetchRequest(
      "get",
      `/backoffice/statistics/${action}.json`,
      {
        contentType: "application/json",
        responseKind: "json",
      }
    );
    let response = await request.perform();
    return await response.json;
  }
}
