<template>
  <div :id="`${$route.name}-view`" class="w-100 p-3" @click.="handleOffClick">
    <!-- help modal -->
    <HelpModalComponent>
      <h5>Screen Configuration</h5>
      <p>Use this page to manage screens on the system level.
        Select an available device to add to the screens list.</p>
    </HelpModalComponent>

    <!--  header + toolbar  -->
    <div class="hstack align-items-center flex-wrap position-sticky mb-3">
      <!-- header -->
      <div class="fs-5 fw-semibold text-capitalize d-flex align-items-center gap-2">
        <span>{{ $route.name }}</span>
        <span>
          <HelpCircleOutline data-bs-toggle="modal" data-bs-target="#help-modal" title="Help" class="cursor-pointer" />
        </span>
      </div>
      <!-- toolbar -->
      <div class="hstack ms-auto fw-semibold gap-2 text-nowrap flex-wrap">
        <!-- add any toolbar buttons here if needed in the future -->
        <button :disabled="!selected" class="btn btn-sm btn-success">
          + Add
        </button>
        <button :disabled="!selected" class="btn btn-sm btn-primary" @click="console.log('edit')">
          Edit
        </button>
        <button :disabled="!selected" class="btn btn-sm btn-danger" @click="console.log('delete')">
          Delete
        </button>
      </div>
    </div>
    <!-- main content -->
    <div>
      <!-- screens list -->
      <div class="card p-3 mb-3">
        <div class="hstack justify-content-between py-1">
          <span class="fw-semibold text-uppercase">Screens</span>
          <small class="text-muted">List of configured screens</small>
        </div>
        <div style="height:40dvh;" class="border table-responsive bg-body-light small">
          <table class="table table-striped table-hover align-middle mb-0">
            <thead class="table-light sticky-top shadow-sm" style="top: 0; z-index: 1;">
              <tr>
                <th v-for="(col, i) in [
                  'ID',
                  'Title',
                  'Location',
                  'Status',
                  'Content',
                  'Playlist',
                  'MAC',
                  'IP',
                  'Last Seen',
                  'Created',
                  'Updated',
                ]" v-bind:key="i">
                  {{ col }}
                </th>
              </tr>
            </thead>
            <tbody>
              <template v-if="screens.length > 0">
                <tr v-for="(screen, i) in screens" v-bind:key="i">
                  <td>{{ screen.id }}</td>
                  <td>{{ screen.title }}</td>
                  <td>{{ screen.location_id }}</td>
                  <td>{{ screen.status }}</td>
                  <td>{{ screen.content }}</td>
                  <td>{{ screen.playlist_id }}</td>
                  <td>{{ screen.mac_address }}</td>
                  <td>{{ screen.ip_address }}</td>
                  <td>{{ screen.last_seen_at }}</td>
                  <td>{{ screen.created_at }}</td>
                  <td>{{ screen.updated_at }}</td>
                </tr>
              </template>
              <template v-else>
                <tr>
                  <td colspan="11" class="text-center">No screens. Add one from available devices.</td>
                </tr>
              </template>
            </tbody>
          </table>
        </div>
      </div>
      <!-- available devices list -->
      <div class="card p-3">
        <div class="hstack justify-content-between py-1">
          <span class="fw-semibold text-uppercase">Available Devices</span>
          <button :disabled="scanning" :class="{ 'animate-flash-infinite': scanning }" 
          v-if="availableDevices.length > 0" class="btn btn-sm btn-primary"
          @click="scanDevices" style="font-size: 6pt;">
            {{ scanning ? 'Scanning...' : 'Scan Network' }}
          </button>
        </div>
        <div style="height:40dvh;" class="border table-responsive bg-body-light small">
          <table class="table table-striped table-hover align-middle mb-0">
            <thead class="table-light sticky-top shadow-sm" style="top: 0; z-index: 1;">
              <tr>
                <th :hidden="availableDevices.length === 0" v-for="(col, i) in [
                  'IP',
                  'MAC',
                ]" v-bind:key="i">
                  {{ col }}
                </th>
              </tr>
            </thead>
            <tbody>
              <template v-if="availableDevices.length > 0">
                <tr v-for="(d, i) in availableDevices" v-bind:key="i">
                  <td>{{ d.ip }}</td>
                  <td>{{ d.mac }}</td>
                </tr>
              </template>
              <template v-else>
                <tr>
                  <td colspan="2" class="text-center p-3">
                    Scan the network for available devices.<br/>
                    <button @click="scanDevices" class="mt-3 btn btn-sm btn-primary"
                    :class="{ 'animate-flash-infinite': scanning }" :disabled="scanning">
                      {{  scanning ? 'Scanning...' : 'Scan Network' }}
                    </button>
                  </td>
                </tr>
              </template>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import HelpCircleOutline from 'vue-material-design-icons/HelpCircleOutline.vue'

export default {
  components: {
    HelpCircleOutline,
  },
  data() {
    return {
      initializing: false,
      scanning: false,
      availableDevices: [],
      screens: [],
      selected: null
    }
  },
  async mounted() {
    try {
      this.initializing = true;
      await this.$axios.get(this.$api + 'screens?all').then(res => {
        this.screens = res.data;
      })
      this.initializing = false;
    } catch (error) {
      console.log(error);
    }
  },
  methods: {
    async scanDevices() {
      this.scanning = true;
      // fetch all available devices in the network
      await this.$axios.get(this.$api + 'screens?networkdevices').then(res => {
        this.availableDevices = res.data;
      })
      this.scanning = false;
    },
    selectDevice(device) {
      this.selected = device;
    },
    handleOffClick() {
      this.selected = null;
    }
  }
}
</script>

<style scoped></style>