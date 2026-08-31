<template>
  <div v-if="!initializing" :id="`${$route.name}-view`" class="w-100 p-3">
    <!-- help modal -->
    <HelpModalComponent>
      <p>
        The calendar is used to schedule screen content for a specific date and time. 
        Below is a list of possible event types and subtypes.
      </p>
      <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
          <thead class="table-light sticky-top shadow-sm">
            <tr class="small text-uppercase">
              <th scope="col">Types</th>
              <th scope="col">Subtypes</th>
            </tr>
          </thead>
          <tbody class="table-group-divider text-capitalize">
            <tr v-for="t in eventTypes" :key="t">
              <td>{{ t }}</td>
              <td>{{eventSubtypes.filter((s) => calendarOptions.events.find((e) => e.subtype === s && e.type ===
                t)).join(', ')}}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </HelpModalComponent>
    <!--  header + toolbar  -->
    <div class="hstack align-items-center flex-wrap position-sticky">
      <!-- header -->
      <div class="fs-5 fw-semibold text-capitalize d-flex align-items-center gap-2">
        <span>{{ $route.name }}</span>
        <span>
          <HelpCircleOutline data-bs-toggle="modal" data-bs-target="#help-modal" title="Help" class="cursor-pointer" />
        </span>
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
      <div class="hstack gap-2 small align-items-center">
        <!-- TODO: add filters -->
        <!-- mdi filter icon-->
        <Filter class="cursor-pointer" />&nbsp;Filters
        <select class="form-select form-select-sm text-capitalize" v-model="filters.events.type">
          <option value="">Event Type</option>
          <option v-for="t in eventTypes.sort()" :key="t" :value="t">{{ t }}</option>
        </select>
        <select :disabled="filters.events.type.length === 0" class="form-select form-select-sm text-capitalize"
          v-model="filters.events.subtype">
          <option value="">Event Subtype</option>
          <option v-for="st in availableSubtypes" :key="st" :value="st">
            {{ st }}
          </option>
        </select>
        <button :disabled="filters.events.type.length === 0 && filters.events.subtype.length === 0" @click="clearFilters" class="btn btn-outline-secondary btn-sm" title="Clear Filters">
          <FilterOffOutline />
        </button>
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
  <div v-else class="d-flex justify-content-center align-items-center">
    <LoadingComponent message="Loading calendar..." />
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
import HelpCircleOutline from 'vue-material-design-icons/HelpCircleOutline.vue'
import Filter from "vue-material-design-icons/Filter.vue"
import FilterOffOutline from "vue-material-design-icons/FilterOffOutline.vue"
import { store } from "@/common/store"

export default {
  name: 'CalendarView',

  components: {
    FullCalendar,
    EditEventModalComponent,
    CreateEventModalComponent,

    HelpCircleOutline,
    Filter,
    FilterOffOutline
  },

  data() {
    return {
      selectedEvent: {
        title: "New Event",
        start: new Date().toISOString().slice(0, 16),
        end: new Date(Date.now() + 60 * 60 * 1000).toISOString().slice(0, 16),
        allDay: false,
        extendedProps: {
          type: "",
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
        },
      },
      eventTypes: [],
      eventSubtypes: [],
      allEvents: [],
      filters: {
        events: {
          type: "",
          subtype: ""
        }
      }
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

        if (
          // set allDay to true if start and end are the same day and 
          // time is 00:00:00 to 23:59:59
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
      this.allEvents = events // unfiltered copy
      this.calendarOptions.events = events
    },
    clearFilters() {
      this.filters.events.type = ""
      this.filters.events.subtype = ""
    }
  },
  computed: {
    availableSubtypes() {
      if (this.filters.events.type === "") {
        return [...this.eventSubtypes].sort()
      }

      return this.eventSubtypes
        .filter(subtype =>
          this.allEvents.some(event =>
            event.type === this.filters.events.type &&
            event.subtype === subtype
          )
        )
        .sort()
    }
  },
  async mounted() {
    try {
      this.initializing = true;

      // initializes event data
      this.processRawEvents(store.events);
      // initialize filters
      this.eventTypes = this.calendarOptions.events.map((e) => e.type).filter((v, i, a) => a.indexOf(v) === i);
      this.eventSubtypes = this.calendarOptions.events.map((e) => e.subtype).filter((v, i, a) => a.indexOf(v) === i);

      this.initializing = false;
    } catch (e) {
      console.log(e.message);
    }
  },
  watch: {
    'filters.events.type': {
      handler() {
        this.filters.events.subtype = ""
      }
    },
    'filters.events': {
      handler() {
        const { type, subtype } = this.filters.events

        this.calendarOptions.events = this.allEvents.filter(e => {
          const typeMatch = type === "" || e.type === type
          const subtypeMatch = subtype === "" || e.subtype === subtype

          return typeMatch && subtypeMatch
        })
      },
      deep: true
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