<template>
  <div :id="`${$route.name}-view`" class="w-100 p-3" @click.="handleOffClick">
    <!-- help modal -->
    <HelpModalComponent>
      <h5>Screen Configuration</h5>
      <p>Use this page to manage screens on the system level.</p>
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
        <button :disabled="!selected" class="btn btn-sm btn-secondary" @click="console.log('delete')">
          Delete
        </button>
      </div>
    </div>
    <div class="card overflow-hidden p-3">
      <!-- main content -->
      <div class="small d-flex flex-column flex-lg-row gap-3">

        <!-- fetched network devices -->
        <div style="min-width: 300px;">
          <!-- continue here with list of devices -->
        </div>

        <!-- active screens -->
        <div>
          <h5>Active Screens</h5>

          <div style="max-height: 70vh; overflow-y: auto;">
            <table class="table table-bordered table-hover align-middle mb-0">
              <thead>
                <tr class="text-nowrap">
                  <th scope="col" class="sticky-top bg-body">ID</th>
                  <th scope="col" class="sticky-top bg-body">TITLE</th>
                  <th scope="col" class="sticky-top bg-body">LOCATION ID</th>
                  <th scope="col" class="sticky-top bg-body">STATUS</th>
                  <th scope="col" class="sticky-top bg-body">CONTENT</th>
                  <th scope="col" class="sticky-top bg-body">PLAYLIST ID</th>
                  <th scope="col" class="sticky-top bg-body">MAC ADDRESS</th>
                  <th scope="col" class="sticky-top bg-body">IP ADDRESS</th>
                  <th scope="col" class="sticky-top bg-body">LAST SEEN AT</th>
                  <th scope="col" class="sticky-top bg-body">CREATED AT</th>
                  <th scope="col" class="sticky-top bg-body">UPDATED AT</th>
                </tr>
              </thead>

              <tbody v-if="!initializing" class="table-group-divider">
                <tr v-show="screens.length > 0" v-for="s in screens" :key="s.id">
                  <td v-for="(value, i) in s" :key="i">
                    {{ value }}
                  </td>
                </tr>

                <tr v-show="screens.length === 0">
                  <td colspan="11">
                    No active screens. Add from available devices.
                  </td>
                </tr>
              </tbody>

              <tbody v-else class="table-group-divider">
                <tr>
                  <td colspan="11">
                    <span class="animate-flash-infinite">Loading screens...</span>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
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
      availableDevices: [],
      screens: [],
      selected: null
    }
  },
  async mounted() {
    try {
      this.initializing = true;
      // fetch all available devices in the network
      await this.$axios.get(this.$api + 'screens?networkdevices').then(res => {
        this.availableDevices = res.data;
      });
      await this.$axios.get(this.$api + 'screens?all').then(res => {
        this.screens = res.data;
      })
      this.initializing = false;
    } catch (error) {
      console.log(error);
    }
  },
  methods: {
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