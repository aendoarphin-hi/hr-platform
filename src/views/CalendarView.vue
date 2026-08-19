<template>
  <div v-if="!initializing" :id="`${$route.name}-view`" class="w-100 p-3">
    <!--  header + toolbar  -->
    <div class="hstack align-items-center flex-wrap position-sticky">
      <!-- header -->
      <div class="fs-5 fw-semibold text-capitalize">
        {{ $route.name }}
      </div>
      <!-- toolbar -->
      <div class="hstack ms-auto fw-semibold gap-2 text-nowrap flex-wrap">
        <div class="btn btn-sm btn-success" @click="createEvent">
          + Create Event
        </div>
      </div>
    </div>
    <!-- filters -->
    <div class="card p-3 mt-3">
      <div class="hstack gap-2">
        <div class="form-check">
          <input class="form-check-input" type="checkbox" id="filter-announcements" v-model="filterAnnouncements">
          <label class="form-check-label" for="filter-announcements">
            Filter Announcements
          </label>
        </div>
      </div>
    </div>
    <!--  calendar  -->
    <div id="calendar-container" class="card p-3 mt-3">
      <FullCalendar :options="calendarOptions" />
    </div>
    <!--  modals  -->
    <EditEventModalComponent :event="selectedEvent" />
    <CreateEventModalComponent />
  </div>
</template>

<script>
import FullCalendar from '@fullcalendar/vue3'

import themePlugin from '@fullcalendar/vue3/themes/forma'
import dayGridPlugin from '@fullcalendar/vue3/daygrid'
import timeGridPlugin from '@fullcalendar/vue3/timegrid'
import listPlugin from '@fullcalendar/vue3/list'

// Styles
import '@fullcalendar/vue3/skeleton.css'
import '@fullcalendar/vue3/themes/forma/theme.css'
import '@fullcalendar/vue3/themes/forma/palettes/blue.css'
import EditEventModalComponent from '@/components/EditEventModalComponent.vue'
import CreateEventModalComponent from '@/components/CreateEventModalComponent.vue'
import { nextTick } from 'vue'
import { Modal } from 'bootstrap'

export default {
  name: 'CalendarView',

  components: {
    FullCalendar,
    EditEventModalComponent,
    CreateEventModalComponent
  },

  data() {
    return {
      selectedEvent: {
        title: "New Event",
        start: new Date().toISOString().slice(0, 16),
        end: new Date(Date.now() + 60 * 60 * 1000).toISOString().slice(0, 16),
        allDay: false,
        extendedProps: {
          category: "",
          subtype: "",
          location: "",
          description: ""
        }
      },
      subtypeColors: {
        // employee
        birthday: '#D9B84C',
        anniversary: '#C9A83E',
        promotion: '#E0C15A',
        "new hire": '#BFA13A',

        // company
        general: '#1b75bc',
        holiday: '#1b75bc',
        training: '#1b75bc',
        meeting: '#1b75bc',

        // announcements
        urgent: '#dc3545',
        safety: '#fd7e14',
        maintenance: '#6f42c1',
        production: '#198754',
        weather: '#0dcaf0'
      },
      initializing: false,
      calendarOptions: {
        plugins: [
          themePlugin,
          dayGridPlugin,
          timeGridPlugin,
          listPlugin
        ],
        initialView: 'dayGridMonth',
        headerToolbar: {
          left: 'prev,next today',
          center: 'title',
          right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
        },
        views: {
          dayGridMonth: {
            dayMaxEventRows: 4
          },
          timeGridWeek: {
            eventMaxStack: 2
          },
          timeGridDay: {
            eventMaxStack: 6
          }
        },
        height: "100%",
        events: [],
        eventClick: (info) => {
          this.selectedEvent = info.event
          nextTick(() => {
            Modal.getOrCreateInstance(
              document.getElementById('edit-event-modal')
            ).show()
          })
        }

      },
    }
  },
  methods: {
    createEvent() {
      nextTick(() => {
        Modal.getOrCreateInstance(
          document.getElementById('create-event-modal')
        ).show()
      })
    },
    updateEvent(event) {
      window.alert("edit event not implemented yet");
    },
    processRawEvents(events) {
      events.forEach(e => {
        const [startDate, startTime] = e.start.split(' ')
        const [endDate, endTime] = e.end.split(' ')

        if ( // set allDay to true if start and end are the same day and time is 00:00:00 to 23:59:59
          startDate === endDate &&
          startTime === '00:00:00' &&
          endTime === '23:59:59'
        ) {
          e.allDay = true
        }

        // color code by event type
        e.color = this.subtypeColors[e.subtype] ?? 'gray'
      })
      // inject events
      this.calendarOptions.events = events

      // if qparam filter=announcements, then filter where category is 'announcment'
      if (this.$route.query.filter === 'announcements') {
        this.calendarOptions.events = this.calendarOptions.events.filter(e => e.category === 'announcement')
      }
    }
  },
  computed: {

  },
  async mounted() {
    try {
      this.initializing = true;

      const res = await this.$axios.get(this.$api + 'events?all=1');
      this.processRawEvents(res.data)

      this.initializing = false;
    } catch (e) {
      console.log(e.message);
    }
  }
}
</script>

<style>
#calendar-container {
  width: 100%;
  height: 80dvh;
  overflow: auto;
}
</style>