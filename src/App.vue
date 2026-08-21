<template>
  <!-- dev tools -->
  <div @click="border = !border" id="border-button" class="btn-sm btn-outline-primary cursor-pointer"
    style="z-index: 1000; position: fixed; bottom: 0; right: 200px; opacity: 0.5">
    {{ border ? "Disable" : "Enable" }} Borders
  </div>
  <div v-if="this.$env === 'development'"
    style="z-index: 1000; position: fixed; bottom: 0; right: 0; background-color: yellow; opacity: 0.5">
    Development Environment
  </div>
  <!-- main content -->
  <div class="d-flex flex-row bg-light" style="height: 100vh; overflow: auto;"
    :class="border ? 'borderized' : ''">
    <SidebarComponent/>
    <router-view class="container" />
  </div>
  <ToastComponent ref="toast" />
</template>

<script>
import SidebarComponent from "@/components/SidebarComponent.vue";
import AuthView from "@/views/AuthView.vue";
import ToastComponent from "@/components/ToastComponent.vue";

export default {
  components: {
    SidebarComponent,
    AuthView,
    ToastComponent
  },
  provide() {
    return {
      toast: {
        show: (title, message, classList) => {
          this.$refs.toast.showToast(title, message, classList);
        }
      }
    };
  },
  data() {
    return {
      border: false,
      loading: false,
    };
  },
  async mounted() {
    this.loading = true
    // do stuff
    this.loading = false
  },
};
</script>

<style>
.borderized *:nth-child(even) {
  border: 1px solid rgba(255, 0, 0, 0.348);
}

.borderized *:nth-child(odd) {
  border: 1px solid rgba(14, 133, 14, 0.393);
}
</style>
