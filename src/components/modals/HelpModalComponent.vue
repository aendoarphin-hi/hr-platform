<template>
  <div class="modal fade" id="help-modal" tabindex="-1" ref="helpModal">
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
  mounted() {
    this.$refs.helpModal.addEventListener("hide.bs.modal", () => {
      // move focus out of the modal BEFORE Bootstrap sets aria-hidden="true" on it.
      // otherwise, if the clicked close button still holds focus (a descendant of the
      // modal), the browser blocks aria-hidden and logs:
      // "Blocked aria-hidden on an element because its descendant retained focus."
      if (document.activeElement && this.$refs.helpModal.contains(document.activeElement)) {
        document.activeElement.blur();
      }
    });
  }
}
</script>

<style scoped>
p {
  white-space: pre-line;
}
</style>