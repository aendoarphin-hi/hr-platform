<template>
  <!-- modal -->
  <div class="modal fade" id="edit-event-modal" ref="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 500px">
      <div class="modal-content shadow">
        <div class="modal-header">
          <div class="d-flex flex-column w-100 gap-1">
            <strong class="text-nowrap overflow-hidden me-4" style="text-overflow: ellipsis"
              :title="updatedEvent.title">
              {{ updatedEvent.title }}
            </strong>
            <div class="d-flex flex-row gap-2 align-items-center">
              <div class="badge rounded-pill text-capitalize" style="width: min-content;"
                :class="badgeClass(updatedEvent.type)">
                {{ formatLabel(updatedEvent.type) }} |
                {{ formatLabel(updatedEvent.subtype) }}
              </div>
              <small class="text-muted">
                <span v-if="updatedEvent.location">
                  <MapMarker /> {{ updatedEvent.location }}&nbsp;&nbsp;&middot;&nbsp;&nbsp;
                </span>
                <CalendarRangeOutline />&nbsp;
                <span v-if="updatedEvent.allDay">{{ formatDate(updatedEvent.start) }}</span>
                <span v-else>{{ formatDate(updatedEvent.start) }} - {{ formatDate(updatedEvent.end) }}</span>
              </small>
            </div>
          </div>
        </div>
        <!-- edit mode body -->
        <div class="modal-body">
          <!-- event description -->
          <p v-if="!editing">
            {{ updatedEvent.description || "No description provided." }}
          </p>
          <textarea class="form-control form-control-sm" placeholder="What is this event about?" v-else
            v-model="updatedEvent.description" style="height: 150px; resize: none;">
          </textarea>
          <!-- event editable fields -->
          <div class="mb-2 d-flex flex-row gap-2 w-100">
            <!-- date range -->
            <div class="w-100">
              <label for="event-edit-start-date" class="small fw-semibold">Start</label>
              <input type="datetime-local" class="form-control form-control-sm" :disabled="!editing"
                name="event-edit-start-date" id="event-edit-start-date" v-model="updatedEvent.start" />
            </div>
            <div class="w-100">
              <label for="event-edit-end-date" class="small fw-semibold">End</label>
              <input type="datetime-local" class="form-control form-control-sm"
                :disabled="!editing || updatedEvent.allDay" name="event-edit-end-date" id="event-edit-end-date"
                v-model="updatedEvent.end" />
            </div>
          </div>

          <!-- location dropdown -->
          <select :disabled="!editing" id="event-edit-location-select" class="form-select form-select-sm"
            v-model="updatedEvent.location_id">
            <option :value="null">Select Location</option>
            <option v-for="l in locations" :key="l.name + '-' + l.id" :value="l.id">
              {{ l.name }}
            </option>
          </select>
        </div>

        <div v-if="confirmDelete" class="modal-footer p-2">
          <p class="px-2 me-auto btn btn-sm bg-danger-subtle text-danger-emphasis rounded">Are you sure you want to
            delete this event?</p>
          <button class="btn btn-sm btn-danger me-2" @click="confirmDelete = false">No</button>
          <button class="btn btn-sm btn-success" @click="deleteEvent();">Yes</button>
        </div>
        <div v-else class="modal-footer p-2">
          <button data-bs-dismiss="modal" v-if="!editing" class="btn btn-sm btn-secondary me-2"
            title="Close">Close</button>
          <button v-if="!editing" class="btn btn-sm btn-danger me-2" @click="confirmDelete = true" title="Delete">
            Delete
          </button>
          <button data-bs-dismiss="modal" v-if="editing" class="btn btn-sm btn-secondary me-2" title="Discard Changes">
            Discard Changes
          </button>
          <button v-if="!editing" class="btn btn-sm btn-primary me-2" :disabled="editing" @click="startEditing()"
            title="Edit event">
            <Pencil />&nbsp;Edit
          </button>
          <button v-if="editing" @click="saveChanges" :disabled="!changed" class="btn btn-sm btn-success"
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
import { store } from "@/common/store";
import { toMySqlDateTime } from "@/common/helpers";

export default {
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
      editing: false,
      changed: false,
      confirmDelete: false,
      updatedEvent: {},
      originalEvent: {},
      locations: [],
    };
  },
  async mounted() {
    this.$refs.modal.addEventListener("hidden.bs.modal", () => {
      this.editing = false;
      this.changed = false;
    });

    // remove focus from any input fields; fix for aria warning after modal close
    const modal = document.getElementById('edit-event-modal');
    modal.addEventListener('hide.bs.modal', () => {
      document.activeElement?.blur();
    });

    // fetch all available locations for the location select dropdown
    const res = (await this.$axios.get(this.$api + 'locations?all=1')).data;
    this.locations = res;
  },

  watch: {
    updatedEvent: {
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

        this.changed = JSON.stringify(updated) !== JSON.stringify(original);
      },
      deep: true
    },

    event(newEvent) {
      this.updatedEvent = structuredClone(newEvent);

      this.updatedEvent.start = this.formatDateTimeLocal(newEvent.start);
      this.updatedEvent.end = this.formatDateTimeLocal(newEvent.end);

      this.changed = false;
      this.editing = false;
    },
  },
  computed: {
  },
  methods: {
    resetChanges() {
      this.editing = false;
      this.changed = false;
      this.updatedEvent = { ...this.event };
    },
    saveChanges() {
      try {
        const data = {
          ...this.updatedEvent,
          start: toMySqlDateTime(this.updatedEvent.start),
          end: toMySqlDateTime(this.updatedEvent.end),
        };

        console.log(data);
      } catch (error) {
        console.error('Error saving changes:', error);
      } finally {
        this.resetChanges();
      }
    },
    async deleteEvent() {
      try { // TODO: add log inserts
        await this.$axios.post(this.$api + "events?delete", {
          id: this.updatedEvent.id
        });
        this.resetChanges();
        store.events = (await this.$axios.get(this.$api + "events?all=1")).data; // refresh store
        Modal.getOrCreateInstance(document.getElementById('edit-event-modal')).hide();
      } catch (error) {
        console.error(error);
      }
    },
    startEditing() {
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
