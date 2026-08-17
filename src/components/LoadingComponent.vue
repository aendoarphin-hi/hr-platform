<template>
  <!-- ===== loading state ===== -->
  <div class="text-center mt-5 py-5">
    <div class="spinner-border text-primary" role="status">
      <span class="visually-hidden">Loading...</span>
    </div>
    <div class="text-muted mt-2 small">{{ message }}</div>
  </div>
</template>

<script>
export default {
  props: {
    message: String
  }
}
</script>
