<template>
  <div class="modal fade" id="help-modal" tabindex="-1">
  <div class="modal-dialog" style="min-width: 800px;">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="help-modal-label">Instructions</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <slot></slot>
      </div>
    </div>
  </div>
</div>
</template>

<script>
export default {
}
</script>

<style scoped>
p {
  white-space: pre-line;
}
</style>