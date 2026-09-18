<template>
  <div :id="`${$route.name}-view`" class="w-100 p-3">
    <!-- help modal -->
    <HelpModalComponent>
      <h5>Screen Configuration</h5>
      <p>Scan the network for available screens. You can then add them to the list of screens.
         Once the screen is added, it will be available for users to manage in the <b>Screens</b> tab.
      </p>
    </HelpModalComponent>

    <!--  header + toolbar  -->
    <div class="hstack align-items-center flex-wrap mb-4">
      <!-- header -->
      <div class="fs-5 fw-semibold text-capitalize d-flex align-items-center gap-2">
        <span>{{ $route.name }}</span>
        <span>
          <HelpCircleOutline data-bs-toggle="modal" data-bs-target="#help-modal" title="Help" class="cursor-pointer" />
        </span>
      </div>
      <!-- toolbar -->
      <div class="hstack ms-auto fw-semibold gap-2 text-nowrap flex-wrap">
        <button :disabled="scanning" class="btn btn-sm btn-primary" @click="scanDevices">
          <span :class="{ 'animate-flash-infinite': scanning }">{{ scanning ? 'Scanning...' : 'Scan Network' }}</span>
        </button>
      </div>
    </div>

    <!-- main content -->
    <div class="d-flex flex-column gap-3 w-100">
      <h5>Available Devices ({{ availableDevices.length }})</h5>
      <div class="rounded overflow-hidden border">
        <table class="table table-hover align-middle mb-0">
          <thead class="table-light sticky-top shadow-sm" style="top: 0; z-index: 1;">
            <tr>
              <th :hidden="availableDevices.length === 0" v-for="(col, i) in [
                'IP',
                'MAC',
              ]" v-bind:key="i">
                {{ col }}
              </th>
              <th class="text-end" scope="col">&nbsp;</th>
            </tr>
          </thead>
          <tbody>
            <template v-if="availableDevices.length > 0">
              <tr v-for="(d, i) in sortedDevices" v-bind:key="i" @mouseover="hoverIndex = i"
                @mouseleave="hoverIndex = -1">
                <td>{{ d.ip }}</td>
                <td>{{ d.mac }} <span
                    class="text-uppercase bg-success-subtle text-success-emphasis rounded-pill badge badge-sm">{{
                      screenExists(d.mac) ? 'Already Added' : '' }}</span></td>
                <td class="text-end">
                  <div :class="{ invisible: hoverIndex !== i }">
                    <button class="btn btn-sm btn-success cursor-pointer" @click="openAddScreenModal(d)">
                      + Add
                    </button>
                  </div>
                </td>
              </tr>
            </template>
            <template v-else>
              <tr style="height: 280px;">
                <td colspan="2" class="text-center p-3">
                  Scan the network for available devices.
                </td>
              </tr>
            </template>
          </tbody>
        </table>
      </div>

    </div>

    <AddDeviceModal ref="addDeviceModal" />
    <EditScreenRecordModal ref="editScreenRecordModal" :screen="selectedScreen" @saved="onScreenSaved" />
  </div>
</template>

<script>
import AddDeviceModal from '@/components/modals/AddDeviceModal.vue';
import EditScreenRecordModal from '@/components/modals/EditScreenRecordModalComponent.vue';
import { Modal } from 'bootstrap';
import { nextTick } from 'vue';
import HelpCircleOutline from 'vue-material-design-icons/HelpCircleOutline.vue'

export default {
  components: {
    HelpCircleOutline,
    AddDeviceModal,
    EditScreenRecordModal
  },
  data() {
    return {
      initializing: false,
      scanning: false,
      hoverIndex: -1,
      screenHoverIndex: -1,
      availableDevices: [],
      screens: [],
      selectedScreen: null,
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
  computed: {
    sortedDevices() {
      return [...this.availableDevices].sort((a, b) => {
        const aParts = a.ip.split(".").map(Number);
        const bParts = b.ip.split(".").map(Number);

        for (let i = 0; i < 4; i++) {
          if (aParts[i] !== bParts[i]) {
            return aParts[i] - bParts[i];
          }
        }

        return 0;
      }).reverse();
    }
  },
  methods: {
    async screenExists(mac) {
      const screens = (await this.$axios.get(this.$api + 'screens?all')).data;
      return screens.some((s) => s.mac_address === mac);
    },
    openEditScreenRecordModal(screen) {
      nextTick(() => {
        // pass a clone so edits in the modal don't leak into the table until saved
        this.selectedScreen = { ...screen };
        Modal.getOrCreateInstance(document.getElementById('edit-screen-record-modal')).show();
      })
    },
    onScreenSaved(updated) {
      const i = this.screens.findIndex((s) => s.id === updated.id);
      if (i !== -1) {
        this.screens.splice(i, 1, { ...this.screens[i], ...updated });
      }
    },
    async scanDevices() {
      this.availableDevices = [];
      this.scanning = true;
      // fetch all available devices in the network
      await this.$axios.get(this.$api + 'screens?networkdevices').then(res => {
        this.availableDevices = res.data;
      })
      this.scanning = false;
    },
    openAddScreenModal(device) {
      nextTick(() => {
        this.$refs.addDeviceModal.setDevice(device);

        Modal.getOrCreateInstance(
          document.getElementById('add-device-modal')
        ).show();
      });
    },
  }
}
</script>

<style scoped></style>