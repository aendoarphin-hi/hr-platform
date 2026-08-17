import { createApp } from "vue";
import axios from "axios";
import App from "@/App.vue";
import router from "@/router";

// styles
import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap/dist/js/bootstrap.bundle.min.js";
import "vue-material-design-icons/styles.css";
import "./assets/styles/main.scss";

// app utilities
import { debounce } from "@/common/helpers.js";
import { config } from "@/common/config.js";
import { globalStore } from "./common/store";

// fix for vue resize observer error
debounce();

const app = createApp(App);

app.config.globalProperties = {
  $appname: config.appName,
  $version: config.appVersion,
  $env: process.env.NODE_ENV,
  $api: config.api,
  $axios: axios,
  $store: globalStore
}

app
  .use(router)
  .mount("#app");
