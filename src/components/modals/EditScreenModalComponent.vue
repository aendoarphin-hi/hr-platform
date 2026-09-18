<template>
  <!-- modal -->
  <div class="modal fade" id="edit-screen-modal" ref="editScreenModal" tabindex="-1">
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
          <small>{{ JSON.stringify(form, null, 2) }}</small><br /><br />
          <p class="small">Use this form to manage the content of a screen.</p>
          <div class="vstack gap-2">
            <input v-model="form.title" type="text" class="form-control form-control-sm" placeholder="Screen Name">
            <div class="hstack gap-2">
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
            </div>
            <div class="rounded border p-2 vstack">
              <!-- instant upload -->
              <div class="mb-2">
                <label for="" class="form-label small">Add Content</label>
                <input type="file" class="form-control form-control-sm" name="" placeholder="" />
              </div>
              <!-- upload from existing -->
              <div>
                <label for="" class="form-label small">Add Existing Content</label>
                <select class="form-select form-select-sm" name="" id="">
                  <option selected :value="null">Select Content</option>
                  <option v-for="c in sortedContent" :key="c.id" :value="c.id">
                    {{ c.filename }}
                  </option>
                </select>
              </div>
            </div>


            <input v-model="form.playlist_id" type="text" class="form-control form-control-sm"
              placeholder="Playlist ID">
            <div class="hstack gap-2">
              <input disabled v-model="form.ip_address" type="text" class="form-control form-control-sm"
                placeholder="IP Address" style="width: 50%">
              <input disabled v-model="form.mac_address" type="text" class="form-control form-control-sm"
                placeholder="MAC Address" style="width: 50%">
            </div>
          </div>
        </div>

        <div class="modal-footer p-2">
          <button type="button" class="btn btn-sm btn-outline-danger me-2" @click="deleteScreen"
              title="Delete">
              Delete
            </button>

            <button type="button" class="btn btn-sm btn-danger me-2" data-bs-dismiss="modal" title="Cancel">
              Cancel
            </button>

            <button :disabled="canSubmit" @click="submit" type="button" class="btn btn-sm btn-success"
              title="Save Screen Changes">
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
  inject: ['toast'],
  emits: ['updated', 'deleted'],
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
      },
      content: [],
    }
  },
  methods: {
    async deleteScreen() {
      try {
        if (!window.confirm('Are you sure you want to delete this screen?')) return;
        await this.$axios.post(this.$api + 'screens?delete', {
          id: parseInt(this.form.id)
        });
        this.$emit('deleted');
        this.toast.show("Screen Deleted", "The screen has been successfully deleted.", "bg-info-subtle text-info-emphasis");
      } catch (error) {
        console.error(error);
        this.toast.show("Error", "There was an error deleting the screen.", "bg-danger-subtle text-danger-emphasis");
      } finally {
        this.hide();
      }
    },
    setScreen(screen) {
      this.form = {
        id: screen.id,
        title: screen.title,
        location_id: screen.location_id,
        status: screen.status,
        content: screen.content,
        playlist_id: screen.playlist_id,
        mac_address: screen.mac_address,
        ip_address: screen.ip_address
      }
    },
    hide() {
      Modal.getOrCreateInstance(document.getElementById('edit-screen-modal')).hide();
    },
    async submit() {
      try {
        if (!window.confirm('Are you sure you want to save these changes?\n\n' + JSON.stringify(this.form, null, 2))) return;
        await this.$axios.put(this.$api + 'screens?update', this.form);
        this.$emit('updated');
        this.hide();
      } catch (error) {
        console.error(error);
      }
    }
  },
  computed: {
    sortedContent() {
      return [...this.content].sort((a, b) => {
        if (a.filename === b.filename) return 0;
        return a.filename < b.filename ? -1 : 1
      })
    },
    canSubmit() {
      return !this.form.title ||
        !this.form.location_id ||
        !this.form.status ||
        !this.form.mac_address ||
        !this.form.ip_address
    }
  },
  async mounted() {
    this.content = (await this.$axios.get(this.$api + 'content?all')).data;
    clearModalFocus(this.$refs.editScreenModal);
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