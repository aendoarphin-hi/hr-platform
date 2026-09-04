<template>
  <!-- modal -->
  <div class="modal fade show" id="edit-event-modal" ref="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 500px">
      <div class="modal-content shadow">
        <div class="modal-header">
          <div class="d-flex flex-column w-100 gap-1">
            <strong class="text-nowrap overflow-hidden me-4" style="text-overflow: ellipsis" :title="editEvent.title">
              {{ editEvent.title }}
            </strong>
            <div class="d-flex flex-row gap-2 align-items-center">
              <div v-if="editEvent.type && editEvent.subtype" class="badge rounded-pill text-capitalize border" style="width: min-content;"
                :class="badgeClass(editEvent.type)">
                {{ editEvent.type }} |
                {{ editEvent.subtype }}
              </div>
              <small class="text-muted d-flex gap-1 align-items-center">
                <span v-if="editEvent.location" class="d-inline-flex align-items-center gap-1">
                  <MapMarker /> {{ editEvent.location }}
                  <span class="separator">&middot;</span>
                </span>
                <span class="d-inline-flex align-items-center gap-1">
                  <CalendarRangeOutline />
                  <span v-if="editEvent.allDay">{{ formatDate(editEvent.start) }}</span>
                  <span v-else>{{ formatDate(editEvent.start) }} - {{ formatDate(editEvent.end) }}</span>
                </span>
              </small>
            </div>
          </div>
        </div>
        <div class="modal-body">
          <!-- event description -->
          <p v-if="!editing" class="lh-sm">
            {{ editEvent.description || "No description provided." }}
          </p>
          <!-- event editable fields -->
          <textarea class="form-control form-control-sm mb-3" placeholder="What is this event about?" v-else
            v-model="editEvent.description" style="height: 150px; resize: none;">
          </textarea>
          <!-- employee selection if event type allows it -->
          <select v-if="editEvent.type === 'employee'" :disabled="!editing" id="event-edit-employee-select"
            class="form-select form-select-sm" v-model="editEvent.employee_num">
            <option :value="editEvent.employee_num">{{ employeeName }}</option>
            <option v-for="employee in sortedEmployees" :key="employee.number" :value="employee.number">
              {{ employee.name }}
            </option>
          </select>
          <div class="mb-2 d-flex flex-row gap-2 w-100">
            <!-- date range -->
            <div class="w-100">
              <label for="event-edit-start-date" class="small fw-semibold">Start</label>
              <input type="datetime-local" class="form-control form-control-sm" :disabled="!editing"
                name="event-edit-start-date" id="event-edit-start-date" v-model="editEvent.start" />
            </div>
            <div class="w-100">
              <label for="event-edit-end-date" class="small fw-semibold">End</label>
              <input type="datetime-local" class="form-control form-control-sm" :disabled="!editing || editEvent.allDay"
                name="event-edit-end-date" id="event-edit-end-date" v-model="editEvent.end" />
            </div>
          </div>

          <!-- location dropdown -->
          <select :disabled="!editing" id="event-edit-location-select" :class="{ disabled: this.editEvent.companyWide !== false}" class="form-select form-select-sm"
            v-model="editEvent.location_id">
            <option :value="null">Select Location</option>
            <option v-for="l in locations" :key="l.name + '-' + l.id" :value="l.id">
              {{ l.name }}
            </option>
          </select>

          <span v-if="editing" class="hstack gap-2 align-items-center form-control-sm">
            <label for="event-edit-all-day" class="small text-nowrap">All Day Event</label>
            <input type="checkbox" class="form-check-input my-0" id="event-edit-all-day" v-model="editEvent.allDay">
            <label for="event-edit-company-wide" class="small text-nowrap">All Locations</label>
            <input type="checkbox" class="form-check-input my-0" id="event-edit-company-wide" v-model="editEvent.companyWide">
          </span>
        </div>
        <!-- confirmation btns before delete-->
        <div v-if="confirmDelete" class="modal-footer p-2">
          <p class="px-2 me-auto btn btn-sm bg-danger-subtle text-danger-emphasis rounded">Are you sure you want to
            delete this event?</p>
          <button class="btn btn-sm btn-danger me-2" @click="confirmDelete = false">No</button>
          <button class="btn btn-sm btn-success" @click="deleteEvent();">Yes</button>
        </div>
        <div v-else class="modal-footer p-2">
          <button data-bs-dismiss="modal" class="btn btn-sm btn-secondary me-2"
          >{{ editing ? 'Cancel' : 'Close' }}</button>
          <button v-if="!editing" class="btn btn-sm btn-danger me-2" @click="confirmDelete = true" title="Delete">
            Delete
          </button>
          <button data-bs-dismiss="modal" v-if="editing" :disabled="!hasChanges" class="btn btn-sm btn-secondary me-2" title="Discard Changes">
            Discard Changes
          </button>
          <button v-if="!editing" class="btn btn-sm btn-primary me-2" :disabled="editing" @click="startEditing()"
            title="Edit event">
            <Pencil />&nbsp;Edit
          </button>
          <button v-if="editing" @click="saveChanges" :disabled="!hasChanges" class="btn btn-sm btn-success"
            title="Save changes">
            <Floppy />&nbsp;Save
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Pencil from "vue-material-design-icons/Pencil.vue";
import Floppy from "vue-material-design-icons/Floppy.vue";
import CalendarRangeOutline from "vue-material-design-icons/CalendarRangeOutline.vue";
import MapMarker from "vue-material-design-icons/MapMarker.vue";
import { Modal } from "bootstrap";
import { formatDate, formatDateTimeLocal, toMySqlDateTime } from "@/common/helpers";

export default {
  components: {
    Pencil,
    Floppy,
    CalendarRangeOutline,
    MapMarker
  },
  props: {
    event: Object, // original event from calendar
  },
  inject: ["toast"],
  emits: ["edited", "deleted"],
  data() {
    return {
      editing: false,
      hasChanges: false,
      confirmDelete: false,
      editEvent: {}, // draft event to be updated
      employees: [],
      locations: [],
    };
  },
  computed: {
    sortedEmployees() {
      return [...this.employees].sort((a, b) => a.name.localeCompare(b.name));
    },
    employeeName() {
      return this.employees.find(e => e.number === this.editEvent.employee_num)?.name;
    }
  },
  watch: {
    editEvent: {
      handler(newValue) {
        const updated = {
          ...newValue,
          start: toMySqlDateTime(newValue.start),
          end: toMySqlDateTime(newValue.end),
        };
        const original = {
          ...this.event,
          start: toMySqlDateTime(this.event.start),
          end: toMySqlDateTime(this.event.end),
        };
        this.hasChanges = JSON.stringify(updated) !== JSON.stringify(original);
      },
      deep: true
    },

    event(newEvent) {
      this.editEvent = this.formatForEdit(newEvent);
      this.hasChanges = false;
      this.editing = false;
    },
  },
  async mounted() {
    this.$refs.modal.addEventListener("hidden.bs.modal", () => {
      this.editing = false;
      this.hasChanges = false;
    });

    // remove focus from any input fields; fix for aria warning after modal close
    const modal = document.getElementById('edit-event-modal');
    modal.addEventListener('hide.bs.modal', () => {
      document.activeElement?.blur();
    });

    // fetch all available locations for the location select dropdown
    const l = (await this.$axios.get(this.$api + 'locations?all=1')).data;
    const e = (await this.$axios.get(this.$api + 'employees?all=1')).data;
    this.locations = l; this.employees = e;
  },

  methods: {
    formatDate,
    formatDateTimeLocal,
    resetChanges() {
      this.editing = false;
      this.hasChanges = false;
      this.confirmDelete = false;
      this.editEvent = this.formatForEdit(this.event);
    },
    async saveChanges() {
      try {
        const data = {
          ...this.editEvent, // format dates for db
          start: toMySqlDateTime(this.editEvent.start),
          end: toMySqlDateTime(this.editEvent.end),
        };
        // All day?
        if (this.editEvent.allDay) {
          data.start = data.start.split(' ')[0] + " 00:00:00";
          data.end = data.start.split(' ')[0] + " 23:59:59";
        }
        // Parse IDs
        if (this.editEvent.id) data.id = parseInt(this.editEvent.id);
        if (this.editEvent.location_id) data.location_id = parseInt(this.editEvent.location_id);
        if (this.editEvent.content_id) data.content_id = parseInt(this.editEvent.content_id);
        // Company wide?
        if (this.editEvent.companyWide) {
          data.location_id = null;
        }
        
        if (!window.confirm("Do you want to save these changes?\n\n" + JSON.stringify(data, null, 2))) return;
        await this.$axios.post(this.$api + "events?update", data);
        this.$emit("edited");
        Modal.getOrCreateInstance(document.getElementById('edit-event-modal')).hide();
        this.toast.show("Event Updated", "The event has been successfully updated.", "bg-info-subtle text-info-emphasis");
        this.resetChanges();
      } catch (error) {
        console.error("Error saving changes:", error);
        this.toast.show("Error: ", error, "bg-info-subtle text-info-emphasis");
      }
    },
    formatForEdit(event) { // format dates for form inputs
      const updated = structuredClone(event);
      updated.start = this.formatDateTimeLocal(event.start);
      updated.end = this.formatDateTimeLocal(event.end);

      return updated;
    },
    async deleteEvent() {
      try { // TODO: add log inserts
        await this.$axios.post(this.$api + "events?delete", {
          id: this.editEvent.id
        });
        this.resetChanges();
        this.$emit("deleted")
        Modal.getOrCreateInstance(document.getElementById('edit-event-modal')).hide();
      } catch (error) {
        console.error(error);
      }
    },
    startEditing() {
      this.editing = true;
      console.log(formatDateTimeLocal(this.editEvent.end))
    },
    badgeClass(type) {
      switch (type) {
        case "employee":
          return "bg-warning-subtle text-warning-emphasis";

        case "company":
          return "bg-info-subtle text-info-emphasis";

        case "announcement":
          return "bg-danger-subtle text-danger-emphasis";

        default:
          return "bg-secondary";
      }
    },
  },
};
</script>

<style scoped></style>
