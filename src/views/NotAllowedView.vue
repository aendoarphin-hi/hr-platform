<template>
  <div class="card border border-danger my-auto p-4" style="max-width: 500px;">
    <div class="d-flex flex-row justify-content-center">
      <img src="@/assets/img/hayden-blue.svg" width="90" alt="Hayden Logo" />&nbsp;&nbsp;
      <span class="fs-1 text-dark text-nowrap"><strong>HAYDEN</strong> {{ this.$appname }}</span>
    </div><br />

    <h5 class="text-center">Unauthorized Access</h5>

    <AlertCircle class="text-danger" style="font-size: 100px;" />

    <br />

    <p class="text-center text-muted">
      You do not have permission to access this application.<br />
      Please contact your administrator or HR for access.
    </p>

    <div class="text-center">
      <a class="btn btn-primary" :href="`mailto:${this.supportEmail}`">
        Contact Support
      </a>
    </div>
  </div>
</template>

<script>
import AlertCircle from 'vue-material-design-icons/AlertCircle.vue'
import { config } from '@/common/config'

export default {
  components: {
    AlertCircle
  },
  data() {
    return {
      supportEmail: config.supportEmail
    }
  }
}
</script>