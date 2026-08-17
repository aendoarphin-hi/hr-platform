<template>
    <div id="global-toast" :class="classList" class="toast align-items-center position-fixed bottom-0 end-0 m-3" role="alert">
      <div class="d-flex">
        <div class="toast-body">
          <strong>{{ title }}</strong>
          <div>{{ message }}</div>
        </div>
        <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
      </div>
    </div>
</template>

<script>
import { Toast } from "bootstrap";

export default {
  name: "GlobalToast",

  data() {
    return {
      title: "",
      message: "",
      classList: "",
      toast: null
    };
  },

  mounted() {
    this.toast = new Toast(document.getElementById("global-toast"));
  },

  methods: {
    async showToast(title, message, classList = "") {
      this.title = title;
      this.message = message;
      this.classList = classList;
      // Vue updates the `:class` binding asynchronously. If we call
      // toast.show() immediately, Bootstrap adds the `show` class, but
      // Vue's pending class patch then rewrites className and wipes out
      // Bootstrap's `show` class (and the custom classes weren't in the
      // DOM yet when show() started). Wait for Vue to flush the classes
      // to the element first, then let Bootstrap add its `show` class.
      await this.$nextTick();
      this.toast.show();
    }
  }
};
</script>