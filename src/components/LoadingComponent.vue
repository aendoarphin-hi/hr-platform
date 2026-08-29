<template>
  <!-- ===== loading state ===== -->
  <div class="text-center py-5 h-100 d-flex flex-column">
    <div class="my-auto">
      <span class="spinner-border text-primary" role="status">
      </span>
      <p class="text-muted mt-2 small animate-flash-infinite">{{ message }}</p>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    message: String
  }
}
</script>
