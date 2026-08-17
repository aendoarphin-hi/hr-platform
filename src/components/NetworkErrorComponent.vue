<!-- Network Error Component -->
<template>
  <div class="text-center mt-5 py-5">
    There was a network error
    <div class="text-muted mt-2 small">Please try again</div>
    <div class="mt-3">
      <refresh onclick="window.location.reload()" :size="32" class="cursor-pointer" />
    </div>
  </div>
</template>

<script>
import Refresh from 'vue-material-design-icons/Refresh.vue'
export default {
  components: {
    Refresh
  },
  data() {
    return {

    }
  }
}
</script>