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
            <p class="small text-muted">
              Create a new event by filling in the details below.
            </p>

            <!-- error message -->
            <div v-if="error" class="mb-3 p-2 small rounded bg-danger-subtle text-danger-emphasis">
              {{ error }}
            </div>
            <!-- event creatable fields -->

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
                <option class="text-capitalize" v-for="s in filteredSubtypes" :key="s" :value="s">
                  {{ s }}
                </option>
              </select>
            </div>

            <!-- employee selection if type is employee -->
            <div class="mb-3">
              <select :disabled="newEvent.type !== 'employee'" required id="event-create-employee" class="form-select form-select-sm" v-model="newEvent.employeeId">
                <option value="">Select Employee</option>
                <option v-for="employee in employees" :key="employee.id" :value="employee.id">
                  {{ employee.name }}
                </option>
              </select>
            </div>

            <!-- description text -->
            <div class="mb-3">
              <textarea id="event-create-description" class="form-control form-control-sm"
                style="min-height: 100px; resize: none;"
                v-model="newEvent.description" placeholder="Event Description"></textarea>
            </div>

            <!-- help description -->
            <p class="small text-muted">
              Select a date range for the event. Content tied to this event will be visible within this date range.
            </p>

            <!-- date range -->
            <div class="mb-3 d-flex flex-row flex-wrap gap-2 w-100">
              <div class="col">
                <label for="event-create-start-date" class="small">Start</label>
                <input required type="datetime-local" class="form-control form-control-sm" id="event-create-start-date"
                  v-model="newEvent.start" />
              </div>
              <div class="col">
                <label for="event-create-end-date" class="small">End</label>
                <input type="datetime-local" class="form-control form-control-sm" id="event-create-end-date"
                  v-model="newEvent.end" />
              </div>
            </div>

            <!-- locations dropdown -->
            <select id="event-create-location" class="form-select form-select-sm" v-model="newEvent.location">
              <option value="">Select Location (Leave blank for company-wide)</option>
              <option v-for="location in locations" :key="location.name + '-' + location.id" :value="location.name">
                {{ location.name || "Company-wide" }}
              </option>
            </select>
          </div>

          <div class="modal-footer p-2">
            <button type="reset" class="btn btn-sm btn-danger me-2" data-bs-dismiss="modal" @click="cancelChanges"
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
import { eventTypeMap } from "@/common/constants";
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
        description: "", // optional
        location: "", // optional
        employeeId: "", // optional
        contentId: "", // optional
        status: "draft", // optional
        start: "",
        end: "",
      },
      locations: [],
      types: [],
      subtypes: [],
      employees: [],
      error: ""
    };
  },

  async mounted() {
    this.$refs.modal.addEventListener("hidden.bs.modal", () => {
      this.cancelChanges();
    });

    // remove focus from any input fields; fix for aria warning after modal close
    const modal = document.getElementById('create-event-modal');
    modal.addEventListener('hide.bs.modal', () => {
      document.activeElement?.blur();
    });

    try {
      // fetch all locations
      const l = (await this.$axios.get(this.$api + 'locations?all=1')).data;
      this.locations = l;
      // fetch all available event types and subtypes
      const e = (await this.$axios.get(this.$api + 'events?all=1')).data;
      this.types = e.map((e) => e.type).filter((v, i, a) => a.indexOf(v) === i);
      this.subtypes = e.map((e) => e.subtype).filter((v, i, a) => a.indexOf(v) === i);
    } catch (e) {
      console.log(e.message);
    }
  },

  computed: {
    canSave() {
      return Boolean(this.newEvent.start && this.newEvent.title && this.newEvent.type && this.newEvent.subtype);
    },
    filteredSubtypes() { // enable subtype when type is selected
      if (this.newEvent.type && eventTypeMap[this.newEvent.type]) {
        return this.subtypes.filter((s) => eventTypeMap[this.newEvent.type].includes(s));
      }
      return this.subtypes;
    },
  },

  methods: {
    cancelChanges() {
      this.newEvent = {
        title: "",
        type: "",
        subtype: "",
        description: "", // optional
        location: "", // optional
        employeeId: "", // optional
        contentId: "", // optional
        status: "draft", // optional
        start: "",
        end: "",
      };
    },
    async createEvent() {
      window.alert(JSON.stringify(this.newEvent, null, 2));
      // try {
      //   // post to php backend
      //   const res = await this.$axios.post("events", this.newEvent);
      //   Modal.getOrCreateInstance(document.getElementById('create-event-modal')).hide();
      //   this.toast.show("Event Created", "The event has been successfully created.", "bg-success-subtle text-success-emphasis");
      // } catch (error) {
      //   this.toast.show("Error creating event:", error, "bg-danger-subtle text-danger-emphasis");
      // }
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
    newEvent: {
      handler(newVal) {
        if (newVal.start && newVal.end && new Date(newVal.start) > new Date(newVal.end)) {
          this.newEvent.start = ''; this.newEvent.end = ''; this.error = "Dates cannot overlap";
        }
      },
      deep: true,
    },
  },
};
</script>

<style scoped></style>