import { reactive } from "vue";
// global reactive store
export let store = reactive({ // eslint-disable-line
  authenticated: false,
  events: [],
  employees: [],
  screens: [],
  playlists: [],
  content: [],
  approvals: [],
  activity: [],
  locations: [],
});