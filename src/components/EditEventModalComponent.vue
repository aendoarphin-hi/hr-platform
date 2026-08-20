<template>
  <!-- modal -->
  <div class="modal fade" id="edit-event-modal" ref="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 500px">
      <div class="modal-content shadow">
        <div class="modal-header">
          <div class="d-flex flex-column w-100 gap-1">
            <strong class="text-nowrap overflow-hidden me-4" style="text-overflow: ellipsis"
              :title="currentEvent.title">
              {{ currentEvent.title }}
            </strong>
            <div class="d-flex flex-row gap-2 align-items-center">
              <div class="badge rounded-pill text-capitalize" style="width: min-content;"
                :class="badgeClass(currentEvent.extendedProps.category)">
                {{ formatLabel(currentEvent.extendedProps.category) }} |
                {{ formatLabel(currentEvent.extendedProps.subtype) }}
              </div>
              <small class="text-muted">
                <MapMarker /> {{ currentEvent.extendedProps.location || "N/A" }} &middot;
                <CalendarRangeOutline />
                <span v-if="currentEvent.allDay">{{ formatDate(currentEvent.start) }}</span>
                <span v-else>{{ formatDate(currentEvent.start) }} - {{ formatDate(currentEvent.end) }}</span>
              </small>
            </div>
          </div>
        </div>

        <div class="modal-body">
          <!-- event description -->
          <p>
            {{ currentEvent.extendedProps.description || "No description provided." }}
          </p>
          <!-- event editable fields -->
          <div v-if="editing" class="mb-2 d-flex flex-row gap-2 w-100">
            <!-- date range -->
            <div class="w-100">
              <label for="event-edit-start-date" class="small fw-semibold">Start</label>
              <input type="datetime-local" class="form-control form-control-sm" :disabled="!editing"
                name="event-edit-start-date" id="event-edit-start-date" v-model="editStart" />
            </div>
            <div class="w-100">
              <label for="event-edit-end-date" class="small fw-semibold">End</label>
              <input type="datetime-local" class="form-control form-control-sm"
                :disabled="!editing || currentEvent.allDay" name="event-edit-end-date" id="event-edit-end-date"
                v-model="editEnd" />
            </div>
          </div>

          <!-- location dropdown -->
          <select v-if="editing" id="event-edit-location-select" class="form-select form-select-sm"
            v-model="editLocation">
            <option value="">Select Location</option>
            <option v-for="l in locations" :key="l.id" :value="l.id">
              {{ l.name || "Company-wide" }}
            </option>
          </select>
        </div>

        <div class="modal-footer p-2">
          <button data-bs-dismiss="modal" v-if="!editing" class="btn btn-sm btn-secondary me-2"
            title="Close">Close</button>

          <button v-if="editing" class="btn btn-sm btn-danger me-2" @click="revertChanges" title="Discard">
            Discard
          </button>

          <button v-if="!editing" class="btn btn-sm btn-primary me-2" :disabled="editing" @click="startEditing"
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


export default {
  emits: ["closeEditModal"],
  components: {
    Pencil,
    Floppy,
    CalendarRangeOutline,
    MapMarker
  },
  props: {
    event: Object,
  },

  data() {
    return {
      detailView: false,
      editing: false,
      editStart: this.event?.start ? this.formatDateTimeLocal(this.event.start) : "",
      editEnd: this.event?.end ? this.formatDateTimeLocal(this.event.end) : "",
      editLocation: this.event?.extendedProps?.location_id || "",
      currentEvent: this.event,
      locations: [],
      changes: [], // if event was updated
    };
  },

  async mounted() {
    this.$refs.modal.addEventListener("hidden.bs.modal", () => {
      this.editing = false;
      this.changes = [];
      this.$emit("closeEditModal");
    });

    // remove focus from any input fields; fix for aria warning after modal close
    const modal = document.getElementById('edit-event-modal');
    modal.addEventListener('hide.bs.modal', () => {
      document.activeElement?.blur();
    });

    // fetch all available locations for the location select dropdown
    const res = (await this.$axios.get(this.$api + 'locations?all=1')).data;
    this.locations = res; // TODO: create distinct query endpoint for this
  },

  watch: {
    event(newEvent) {
      this.currentEvent = newEvent;
      this.editing = false;
      this.editStart = newEvent?.start ? this.formatDateTimeLocal(newEvent.start) : "";
      this.editEnd = newEvent?.end ? this.formatDateTimeLocal(newEvent.end) : "";
      this.editLocation = newEvent?.extendedProps?.location_id || "";
      this.changes = [];
    },
  },

  computed: {
    hasChanges() {
      if (!this.currentEvent) return false;

      const originalStart = this.currentEvent.start ? this.formatDateTimeLocal(this.currentEvent.start) : "";
      const originalEnd = this.currentEvent.end ? this.formatDateTimeLocal(this.currentEvent.end) : "";
      const originalLocation = this.currentEvent.extendedProps?.location || "";

      return (
        this.editStart !== originalStart ||
        this.editEnd !== originalEnd ||
        this.editLocation !== originalLocation
      );
    },
  },

  methods: {
    addChange() {
      this.changes.push("test");
      console.log(this.changes);
    },
    removeChange() {
      this.changes.pop();
      console.log(this.changes);
    },
    revertChanges() {
      this.editing = false;
      this.changes = [];
      this.editStart = this.currentEvent?.start ? this.formatDateTimeLocal(this.currentEvent.start) : "";
      this.editEnd = this.currentEvent?.end ? this.formatDateTimeLocal(this.currentEvent.end) : "";
      this.editLocation = this.currentEvent?.extendedProps?.location || "";
    },
    saveChanges() {
      window.alert("TODO: PUT req to update record.");
    },
    startEditing() {
      this.editStart = this.currentEvent?.start ? this.formatDateTimeLocal(this.currentEvent.start) : "";
      this.editEnd = this.currentEvent?.end ? this.formatDateTimeLocal(this.currentEvent.end) : "";
      this.editLocation = this.currentEvent?.extendedProps?.location || "Blah";
      this.editing = true;
    },
    formatLabel(value) {
      if (!value) return "-";

      return value.replace(/_/g, " ").replace(/\b\w/g, (c) => c.toUpperCase());
    },
    formatDate(value) {
      if (!value) return "-";

      return new Date(value).toLocaleDateString();
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
    badgeClass(category) {
      switch (category) {
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
