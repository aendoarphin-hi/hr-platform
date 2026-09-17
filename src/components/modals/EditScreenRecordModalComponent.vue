<template>
  <!-- modal -->
  <div class="modal fade" id="edit-screen-record-modal" ref="editScreenRecordModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 500px;">
      <div class="modal-content shadow">

        <div class="modal-header">
          <div class="d-flex align-items-center w-100">
            <strong class="text-nowrap overflow-hidden me-4" style="text-overflow: ellipsis">
              Edit Screen
            </strong>
          </div>
        </div>

        <div class="modal-body">
          <p class="small">Update the details for this screen.This will update the actual DB record.</p>
          <div class="vstack gap-2">
            <input v-model="form.title" type="text" class="form-control form-control-sm" placeholder="Screen Name">
            <select v-model="form.location_id" class="form-select form-select-sm">
              <option :value="null">Select Location</option>
              <option v-for="l in locations" :key="l.name + '-' + l.id" :value="l.id">
                {{ l.name }}
              </option>
            </select>
            <select v-model="form.status" class="form-select form-select-sm">
              <option :value="null">Select Status</option>
              <option value="online">Online</option>
              <option value="offline">Offline</option>
              <option value="disabled">Disabled</option>
            </select>
            <input v-model="form.content" type="text" class="form-control form-control-sm" placeholder="Content">
            <input v-model="form.playlist_id" type="text" class="form-control form-control-sm" placeholder="Playlist ID">
            <div class="hstack gap-2">
              <input v-model="form.ip_address" type="text" class="form-control form-control-sm" placeholder="IP Address"
                style="width: 50%">
              <input v-model="form.mac_address" type="text" class="form-control form-control-sm" placeholder="MAC Address"
                style="width: 50%">
            </div>
          </div>
        </div>

        <div class="modal-footer p-2">
          <button type="button" class="btn btn-sm btn-danger me-2" data-bs-dismiss="modal" title="Cancel">
            Cancel
          </button>

          <button :disabled="canSubmit" @click="submit" type="button" class="btn btn-sm btn-success" title="Save Screen">
            Save
          </button>
        </div>

      </div>
    </div>
  </div>
</template>

<script>
import { clearModalFocus } from '@/common/helpers';
import { Modal } from 'bootstrap';

export default {
  props: {
    screen: Object
  },
  data() {
    return {
      locations: [],
      form: {
        id: null,
        title: null,
        location_id: null,
        status: null,
        content: null,
        playlist_id: null,
        mac_address: null,
        ip_address: null
      }
    }
  },
  methods: {
    hide() {
      Modal.getOrCreateInstance(document.getElementById('edit-screen-record-modal')).hide();
    },
    async submit() {
      try {
        if (!window.confirm('Are you sure you want to save these changes?\n\n' + JSON.stringify(this.form, null, 2))) return;
        // NOTE: adjust this endpoint/verb to match your actual update route -
        // mirrored the query-string style used by the other screens? calls.
        await this.$axios.put(this.$api + 'screens?update', this.form);
        this.$emit('saved', { ...this.form });
        this.hide();
      } catch (error) {
        console.error(error);
      }
    }
  },
  computed: {
    canSubmit() {
      return !this.form.title ||
        !this.form.location_id ||
        !this.form.status ||
        !this.form.mac_address ||
        !this.form.ip_address
    }
  },
  async mounted() {
    clearModalFocus(this.$refs.editScreenRecordModal);
    this.locations = (await this.$axios.get(this.$api + 'locations?all')).data
  },
  watch: {
    screen: {
      immediate: true,
      handler() {
        if (!this.screen) return;
        this.form = {
          id: this.screen.id,
          title: this.screen.title,
          location_id: this.screen.location_id,
          status: this.screen.status,
          content: this.screen.content,
          playlist_id: this.screen.playlist_id,
          mac_address: this.screen.mac_address,
          ip_address: this.screen.ip_address
        };
      }
    }
  }
}
</script>