import { createApp } from "vue";
import axios from "axios";
import App from "@/App.vue";
import router from "@/router";

// styles/component libraries
import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap/dist/js/bootstrap.bundle.min.js";
import 'bootstrap-vue-next/dist/bootstrap-vue-next.css'
import "vue-material-design-icons/styles.css";
import "./assets/styles/main.scss";
import "animate.css";

// common components
import LoadingComponent from "@/components/LoadingComponent.vue";
import HelpModalComponent from "@/components/modals/HelpModalComponent.vue";

// app utilities
import { debounce } from "@/common/helpers.js";
import { config } from "@/common/config.js";

// fix for vue resize observer error
debounce();

const app = createApp(App);

app.config.globalProperties = {
  $appname: config.appName,
  $version: config.appVersion,
  $env: process.env.NODE_ENV,
  $api: config.api,
  $axios: axios,
}

console.log("Hayden " + config.appName + " v" + config.appVersion);

app
  .component("LoadingComponent", LoadingComponent)
  .component("HelpModalComponent", HelpModalComponent)
  .use(router)
  .mount("#app");
