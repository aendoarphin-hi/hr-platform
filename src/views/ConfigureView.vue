<template>
  <div :id="`${$route.name}-view`" class="w-100 p-3">
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
        <button class="btn btn-sm btn-success">
          + Add
        </button>
        <button class="btn btn-sm btn-primary" disabled @click="console.log('edit')">
          Edit
        </button>
        <button class="btn btn-sm btn-secondary" disabled @click="console.log('delete')">
          Delete
        </button>
      </div>
    </div>
  </div>
</template>
<script>
import HelpCircleOutline from 'vue-material-design-icons/HelpCircleOutline.vue'
export default {
  components: {
    HelpCircleOutline
  },
  data() {
    return {
      availableDevices: []
    }
  },
  async mounted() {
    try {
      // fetch all available devices in the network
      await this.$axios.get(this.$api + 'screens?networkdevices').then(res => {
        this.availableDevices = res.data;
      });
    } catch (error) {
      console.log(error);
    }
  }
}
</script>
<style></style>