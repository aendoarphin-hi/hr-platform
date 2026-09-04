<template>
  <!-- modal -->
  <form @submit.prevent="createEvent">
    <div class="modal fade" id="create-event-modal" ref="modal" tabindex="-1" role="dialog">
      <div class="modal-dialog modal-dialog-centered" style="max-width: 500px;">
        <div class="modal-content shadow">
          <div class="modal-header">
            <div class="d-flex align-items-center w-100">
              <strong class="text-nowrap overflow-hidden me-4" style="text-overflow: ellipsis">
                New Event
              </strong>
            </div>
          </div>
          <!-- help description -->
          <div class="modal-body">
            <transition enter-active-class="animate__animated animate__fadeIn animate__faster">
              <!-- error message -->
              <div v-if="error" class="mb-3 p-2 small rounded bg-danger-subtle text-danger-emphasis">
                {{ error }}
              </div>
            </transition>
            <p class="small text-muted">
              Create a scheduled event by filling in the details below.
            </p>
            <!-- event creation fields -->
            <!-- title text -->
            <div class="w-100">
              <input required type="text" class="form-control form-control-sm mb-3" placeholder="Event Title"
                id="event-create-title" v-model="newEvent.title" />
            </div>

            <!-- type + subtype dropdown-->
            <div class="mb-3 d-flex flex-row gap-2 w-100">
              <select required id="event-create-type" class="form-select form-select-sm text-capitalize"
                v-model="newEvent.type">
                <option value="">Select Type</option>
                <option class="text-capitalize" v-for="t in types" :key="t" :value="t">
                  {{ t }}
                </option>
              </select>

              <select required id="event-create-subtype" :disabled="this.newEvent.type.length === 0"
                class="form-select form-select-sm text-capitalize" v-model="newEvent.subtype">
                <option value="">Select Subtype</option>
                <option class="text-capitalize" v-for="st in subtypes" :key="st" :value="st">
                  {{ st }}
                </option>
              </select>
            </div>
            <p class="small">Employee events can be tied to a specific employee</p>
            <!-- employee selection if type is employee -->
            <div class="mb-3">
              <select :disabled="newEvent.type !== 'employee'" required id="event-create-employee"
                class="form-select form-select-sm" v-model="newEvent.employee_num">
                <option value="">Select Employee</option>
                <option v-for="employee in employees.sort((a, b) => a.name.localeCompare(b.name))" :key="employee.number"
                  :value="employee.number">
                  {{ employee.name }}
                </option>
              </select>
            </div>

            <!-- description text -->
            <div class="mb-3">
              <textarea id="event-create-description" class="form-control form-control-sm"
                style="min-height: 100px; resize: none;" v-model="newEvent.description"
                placeholder="What is this event about? (optional)"></textarea>
            </div>
            <!-- help description -->
            <p class="small text-muted lh-sm mb-0">
              The start and end date/time of the event will determine how long the content will be visible.
            </p>
            <!-- date range -->
            <div class="mb-3 d-flex flex-row flex-wrap gap-2 w-100">
              <div class="col">
                <label for="event-create-start-date" class="small">Start</label>
                <input required type="datetime-local" class="text-uppercase form-control form-control-sm"
                  id="event-create-start-date" v-model="newEvent.start" />
              </div>
              <div class="col">
                <label for="event-create-end-date" class="small">End</label>
                <input type="datetime-local" :disabled="newEvent.allDay"
                  class="text-uppercase form-control form-control-sm" id="event-create-end-date"
                  v-model="newEvent.end" />
              </div>
            </div>

            <!-- locations dropdown -->
            <select id="event-create-location" required :disabled="newEvent.companyWide"
              class="form-select form-select-sm mb-3" v-model="newEvent.location_id">
              <option :value="null">Select Location</option>
              <option v-for="location in locations" :key="location.name + '-' + location.id" :value="location.id">
                {{ location.name }}
              </option>
            </select>

            <span class="hstack gap-2 align-items-center form-control-sm">
              <label for="event-create-all-day" class="small text-nowrap">All Day Event</label>
              <input type="checkbox" class="form-check-input my-0" id="event-create-all-day" v-model="newEvent.allDay">
              <label for="event-create-company-wide" class="small text-nowrap">All Locations</label>
              <input type="checkbox" class="form-check-input my-0" id="event-create-company-wide"
                v-model="newEvent.companyWide">
            </span>
          </div>

          <div class="modal-footer p-2">
            <button type="reset" class="btn btn-sm btn-danger me-2" data-bs-dismiss="modal" @click="clearChanges"
              title="Cancel">
              Cancel
            </button>

            <button type="submit" :disabled="!canSave" class="btn btn-sm btn-success" title="Create Event">
              + Create
            </button>
          </div>
        </div>
      </div>
    </div>
  </form>
</template>

<script>
import { eventTypes } from "@/common/constants";
import { store } from "@/common/store";
import { Modal } from "bootstrap";

export default {
  components: {

  },

  inject: ["toast"],

  data() {
    return {
      newEvent: {
        title: "",
        type: "",
        subtype: "",
        start: "",
        end: "",
        description: "", // optional
        location_id: null, // optional
        employee_num: null, // optional
        content_id: null, // optional
        companyWide: false // optional
      },
      locations: [],
      employees: [],
      error: ""
    };
  },
  async mounted() {
    try {
      this.$refs.modal.addEventListener("hidden.bs.modal", () => {
        this.clearChanges();
      });

      this.locations = (await this.$axios.get(this.$api + "locations?all=1")).data;
      this.employees = (await this.$axios.get(this.$api + "employees?all=1")).data;

      // remove focus from any input fields; FIX for aria warning after modal close
      const modal = document.getElementById('create-event-modal');
      modal.addEventListener('hide.bs.modal', () => {
        document.activeElement?.blur();
      });
    } catch (error) {
      console.log(error);
    }
  },

  emits: ["created"],

  computed: {
    types() {
      return Object.keys(eventTypes);
    },
    subtypes() {
      return eventTypes[this.newEvent.type] ?? [];
    },
    canSave() {
      return Boolean(this.newEvent.start && this.newEvent.title && this.newEvent.type && this.newEvent.subtype);
    },
  },

  methods: {
    clearChanges() {
      this.newEvent = {
        title: "",
        type: "",
        subtype: "",
        start: "",
        end: "",
        description: "", // optional
        location_id: null, // optional
        employee_num: null, // optional
        content_id: null, // optional
        companyWide: false // optional
      };
    },
    async createEvent() {
      try {
        // is it one-day?
        if (this.newEvent.allDay) {
          this.newEvent.start = this.newEvent.start.split('T')[0] + ' 00:00';
          this.newEvent.end = this.newEvent.start.split(' ')[0] + ' 23:59';
        }
        // is it company-wide?
        if (this.newEvent.companyWide) this.newEvent.location_id = null;
        // set default location if company wide unchecked and no location selected
        if (!this.newEvent.location_id && !this.newEvent.companyWide) this.newEvent.location_id = 1;
        // format for mysql datetime
        this.newEvent.start = this.newEvent.start.replace('T', ' ') + ':00'
        this.newEvent.end = this.newEvent.end.replace('T', ' ') + ':00'
        // parse any ids to int
        this.newEvent.content_id = this.newEvent.content_id ? parseInt(this.newEvent.content_id) : null;
        this.newEvent.employee_num = this.newEvent.employee_num ? parseInt(this.newEvent.employee_num) : null;
        this.newEvent.location_id = this.newEvent.location_id ? parseInt(this.newEvent.location_id) : null;
        // post
        await this.$axios.post(this.$api + "events?new", this.newEvent);
        this.$emit("created")
        this.toast.show("Event Created", "The event has been successfully created.", "bg-success-subtle text-success-emphasis");
      } catch (error) {
        this.toast.show("Error creating event:", error, "bg-danger-subtle text-danger-emphasis");
      } finally {
        this.clearChanges();
        Modal.getOrCreateInstance(document.getElementById('create-event-modal')).hide();
      }
    },
    formatDateTimeLocal(value) {
      if (!value) return "";
      const date = new Date(value);
      const year = date.getFullYear();
      const month = String(date.getMonth() + 1).padStart(2, '0');
      const day = String(date.getDate()).padStart(2, '0');
      const hours = String(date.getHours()).padStart(2, '0');
      const minutes = String(date.getMinutes()).padStart(2, '0');

      return `${year}-${month}-${day}T${hours}:${minutes}`;
    },
  },
  watch: {
    'newEvent.type': {
      handler() {
        this.newEvent.subtype = '';
      },
    },
    newEvent: {
      handler(newVal) {
        if (newVal.start && newVal.end && new Date(newVal.start) > new Date(newVal.end)) {
          this.newEvent.end = ''; this.error = "Dates cannot overlap";
        }
      },
      deep: true,
    },
  },
};
</script>

<style scoped></style>