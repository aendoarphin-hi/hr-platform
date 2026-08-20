import { reactive } from "vue";
// global store tracking (just has auth for now); make it reactive, so any
// values coming from this.$store (declared from any component) will be updated according
// the latest value of store in store.js
export const store = reactive({
  authenticated: null,
  events: []
});